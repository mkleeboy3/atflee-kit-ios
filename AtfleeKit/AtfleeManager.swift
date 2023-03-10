//
//  AtfleeManager.swift
//  AtfleeKit
//
//  Created by Ming on 2023/03/03.
//

import Foundation
import Combine
import CoreBluetooth
import AtfleeBaseKit

// - MARK: Public Interfaces

extension AtfleeManager {
  public var bluetoothStatePublisher: AnyPublisher<AtfleeBluetoothStateType, Never> {
    bluetoothStateSubject
      .share()
      .eraseToAnyPublisher()
  }
  
  public var scanStatePublisher: AnyPublisher<AtfleeScanStateType, Never> {
    scanStateSubject
      .share()
      .eraseToAnyPublisher()
  }
  
  public var scannedDevicesPublisher: AnyPublisher<[AtfleeDevice], Never> {
    scannedDevicesSubject
      .share()
      .eraseToAnyPublisher()
  }
  
  public var connectionStatePublisher: AnyPublisher<AtfleeConnectionStateType, Never> {
    connectionStateSubject
      .share()
      .eraseToAnyPublisher()
  }
  
  public var measurementStatePublisher: AnyPublisher<AtfleeMeasurementStateType, Never> {
    measurementStateSubject
      .share()
      .eraseToAnyPublisher()
  }
  
  public var weightMeasurementPublisher: AnyPublisher<AtfleeWeightMeasurement, AtfleeErrorType> {
    weightMeasurementSubject
      .share()
      .eraseToAnyPublisher()
  }
  
  public func updateUserData(_ userData: AtfleeUser) {
    manager.update(userData.toICUserInfo())
  }
  
  public func startScan(
    devicesToScan: [AtfleeDeviceType] = [],
    timeoutInSeconds: Int = 30
  ) throws {
    guard isBluetoothAvailable else { throw AtfleeErrorType.bluetoothUnavailable }
    
    scanStateSubject
      .send(.scanning)
    
    scannedDevicesSubject
      .send([])
    
    self.devicesToScan = devicesToScan
    
    manager.scanDevice(self)
    
    self.endScanTask?.cancel()
    self.endScanTask = DispatchWorkItem { [weak self] in
      if self?.isScanning ?? false {
        self?.stopScan()
      }
    }
    
    let timeoutInDispatchTimeInterval = DispatchTimeInterval.seconds(timeoutInSeconds)
    DispatchQueue.main.asyncAfter(
      deadline: .now() + timeoutInDispatchTimeInterval,
      execute: endScanTask!
    )
  }
  
  public func stopScan() {
    endScanTask?.cancel()
    manager.stopScan()
    
    scanStateSubject
      .send(.notScanning)
  }
  
  public func connectToDevice(_ device: AtfleeDevice) throws {
    guard isBluetoothAvailable else { throw AtfleeErrorType.bluetoothUnavailable }
    
    guard connectionStateSubject.value == .disconnected else { throw AtfleeErrorType.connectionInProgress }
    
    connectionStateSubject
      .send(.connecting)
    
    if isScanning {
      stopScan()
    }
    
    manager.add(device.toICDevice()) { [weak self] _, statusCode in
      if statusCode == .success {
        self?.connectedDevice = device
        
        self?.connectionStateSubject
          .send(.connected)
      } else {
        self?.connectionStateSubject
          .send(.disconnected)
      }
    }
  }
  
  public func disconnect() {
    guard let connectedDevice = self.connectedDevice else { return }
    
    manager.remove(connectedDevice.toICDevice()) { [weak self] _, statusCode in
      if statusCode == .success {
        self?.connectionStateSubject
          .send(.disconnected)
        
        self?.clearStates()
      }
    }
  }
}

public class AtfleeManager: NSObject {
  public static let shared = AtfleeManager()
  
  private var bluetoothStateSubject = CurrentValueSubject<AtfleeBluetoothStateType, Never>(.unknown)
  private var scanStateSubject = CurrentValueSubject<AtfleeScanStateType, Never>(.notScanning)
  private var scannedDevicesSubject = CurrentValueSubject<[AtfleeDevice], Never>([])
  private var connectionStateSubject = CurrentValueSubject<AtfleeConnectionStateType, Never>(.disconnected)
  private var measurementStateSubject = CurrentValueSubject<AtfleeMeasurementStateType, Never>(.idle)
  private var weightMeasurementSubject = PassthroughSubject<AtfleeWeightMeasurement, AtfleeErrorType>()
  
  private var devicesToScan: [AtfleeDeviceType] = []
  private var endScanTask: DispatchWorkItem?
  
  private var connectedDevice: AtfleeDevice?
  private let manager = ICDeviceManager()
  
  private var isBluetoothAvailable: Bool {
    let bluetoothState = bluetoothStateSubject.value
    switch (bluetoothState) {
      case .poweredOn:
        return true
      case .unknown:
        fallthrough
      case .unsupported:
        fallthrough
      case .unauthorized:
        fallthrough
      case .poweredOff:
        fallthrough
      @unknown default:
        return false
    }
  }
  
  private var isScanning: Bool {
    let scanState = scanStateSubject.value
    return scanState.isScanning
  }
  
  private var scannedDevices: [AtfleeDevice] {
    let devices = scannedDevicesSubject.value
    return devices
  }
  
  private override init() {
    super.init()
    
    manager.initMgr()
    manager.delegate = self
    
    updateUserData(AtfleeUser.default)
  }
  
  private func onWeightDataReceived(_ data: ICWeightData) {
    weightMeasurementSubject
      .send(AtfleeWeightMeasurement.fromICWeightData(data))
  }
  
  private func clearStates() {
    scanStateSubject.send(.notScanning)
    scannedDevicesSubject.send([])
    connectionStateSubject.send(.disconnected)
    measurementStateSubject.send(.idle)
    
    endScanTask?.cancel()
    endScanTask = nil
    connectedDevice = nil
  }
}

extension AtfleeManager: ICScanDeviceDelegate {
  public func onScanResult(_ deviceInfo: ICScanDeviceInfo!) {
    // TODO: filter using devices to scan
    
    if !scannedDevices.contains(where: { $0.macAddress == deviceInfo.macAddr }) {
      var scannedDevices = scannedDevices
      scannedDevices.append(AtfleeDevice.fromICScanDeviceInfo(deviceInfo))
      
      scannedDevicesSubject
        .send(scannedDevices)
    }
  }
}

extension AtfleeManager: ICDeviceManagerDelegate {
  public func onInitFinish(_ bSuccess: Bool) {}
  
  public func onBleState(_ state: ICBleState) {
    bluetoothStateSubject
      .send(AtfleeBluetoothStateType.fromICBleState(state))
  }
  
  public func onDeviceConnectionChanged(_ device: ICDevice!, state: ICDeviceConnectState) {
    connectionStateSubject
      .send(AtfleeConnectionStateType.fromICDeviceConnectState(state))
  }
  
  public func onReceiveMeasureStepData(_ device: ICDevice!, step: ICMeasureStep, data: NSObject!) {
    switch step {
      case ICMeasureStepMeasureWeightData:
        measurementStateSubject
          .send(.unstableWeight)
        if let weightData = data as? ICWeightData {
          onWeightDataReceived(weightData)
        }
        break
        
      case ICMeasureStepAdcStart:
        measurementStateSubject
          .send(.startingAnalysis)
        break
        
      case ICMeasureStepAdcResult:
        measurementStateSubject
          .send(.analysisComplete)
        if let weightData = data as? ICWeightData {
          onWeightDataReceived(weightData)
        }
        break
        
      case ICMeasureStepMeasureOver:
        measurementStateSubject
          .send(.measurementComplete)
        break
        
      default:
        break
    }
  }
}

//
//  MainViewModel.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/23.
//

import Foundation
import Combine
import AtfleeKit

class MainViewModel: ViewModelProtocol {
  private let manager = AtfleeManager.shared
  
  @Published var scannedDevices: [AtfleeDevice] = []
  @Published var bluetoothState: AtfleeBluetoothStateType = .unknown
  @Published var scanState: AtfleeScanStateType = .notScanning
  @Published var connectionState: AtfleeConnectionStateType = .disconnected
  @Published var measurementState: AtfleeMeasurementStateType = .idle
  @Published var measurement: AtfleeWeightMeasurement?
  
  public var scanning: Bool {
    switch (scanState) {
      case .scanning:
        return true
        
      case .notScanning:
        return false
        
      @unknown default:
        fatalError()
    }
  }
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    subscribeToBluetoothStatePublisher()
    subscribeToScanStatePublisher()
    subscribeToScannedDevicesPublisher()
    subscribeToConnectionStatePublisher()
    subscribeToMeasurementStatePublisher()
    subscribeToWeightMeasurementPublisher()
  }
  
  private func subscribeToBluetoothStatePublisher() {
    manager.bluetoothStatePublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        self?.bluetoothState = state
      }
      .store(in: &cancellables)
  }
  
  private func subscribeToScanStatePublisher() {
    manager.scanStatePublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        self?.scanState = state
      }
      .store(in: &cancellables)
  }
  
  private func subscribeToScannedDevicesPublisher() {
    manager.scannedDevicesPublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] devices in
        self?.scannedDevices = devices
      }
      .store(in: &cancellables)
  }
  
  private func subscribeToConnectionStatePublisher() {
    manager.connectionStatePublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        self?.connectionState = state
      }
      .store(in: &cancellables)
  }
  
  private func subscribeToMeasurementStatePublisher() {
    manager.measurementStatePublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        self?.measurementState = state
      }
      .store(in: &cancellables)
  }
  
  private func subscribeToWeightMeasurementPublisher() {
    manager.weightMeasurementPublisher
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { errorType in
        print("error")
      }, receiveValue: { [weak self] measurement in
        self?.measurement = measurement
      })
      .store(in: &cancellables)
  }
  
  func startScan() {
    do {
      try manager.startScan()
    } catch let atfleeError as AtfleeErrorType {
      print("atfleeErrorType: \(atfleeError)")
    } catch let commonError {
      print("\(commonError)")
    }
  }
  
  func stopScan() {
    manager.stopScan()
  }
  
  func connectToDevice(_ device: AtfleeDevice) {
    do {
      try manager.connectToDevice(device)
    } catch let atfleeError as AtfleeErrorType {
      print("atfleeErrorType: \(atfleeError)")
    } catch let commonError {
      print("\(commonError)")
    }
  }
  
  func disconnect() {
    manager.disconnect()
  }
}


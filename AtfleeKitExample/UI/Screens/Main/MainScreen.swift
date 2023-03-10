//
//  MainScreen.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/22.
//

import SwiftUI
import Combine
import AtfleeKit

struct MainScreen: View {
  @StateObject var vm = MainViewModel()
  
  var dateFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    return dateFormatter
  }
  
  var body: some View {
    VStack {
      Spacer()
      
      devicesView
      
      Spacer()
      
      measurementsView
      
      Spacer()
      
      statusView
      
      Spacer()
      
      buttonsView
      
      Spacer()
    }
    .padding()
  }
  
  var devicesView: some View {
    VStack {
      if (vm.scannedDevices.isEmpty) {
        Text("No devices yet!")
      } else {
        List {
          ForEach(vm.scannedDevices, id: \.macAddress) { device in
            Button {
              vm.connectToDevice(device)
            } label: {
              Text("\(device.name)\n\(device.macAddress)")
            }
          }
        }
      }
    }
    .padding()
    .frame(maxWidth: .infinity)
    .frame(height: 150)
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .stroke(.black)
    )
    .padding()
  }
  
  var measurementsView: some View {
    VStack {
      if (vm.measurement == nil) {
        Text("No measurements yet!")
      } else {
        List {
          let measurement = vm.measurement
          VStack {
            Text("weight: \(measurement!.weight)")
            Text("muscleMass: \(measurement!.muscleMass)")
            Text("musclePercent: \(measurement!.musclePercent)")
            Text("ffm: \(measurement!.ffm)")
            Text("visceralFat: \(measurement!.visceralFat)")
            Text("subcutaneousFatPercent: \(measurement!.subcutaneousFatPercent)")
            Text("bodyFatPercent: \(measurement!.bodyFatPercent)")
            Text("bmr: \(measurement!.bmr)")
          }
        }
      }
    }
    .padding()
    .frame(maxWidth: .infinity)
    .frame(height: 300)
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .stroke(.black)
    )
    .padding()
  }
  
  var statusView: some View {
    VStack(alignment: .leading) {
      Divider()
      
      Text("bluetooth state: \(vm.bluetoothState.label)")
      
      Text("scan state: \(vm.scanState.label)")
      
      Text("connection state: \(vm.connectionState.label)")
      
      Text("measurement state: \(vm.measurementState.label)")
      
      Divider()
    }
    .frame(maxWidth: .infinity, maxHeight: 0)
    .padding()
  }
  
  var buttonsView: some View {
    HStack {
      Spacer()
      
      Button {
        vm.startScan()
      } label: {
        Text("scan")
      }
      
      Spacer()
      
      Button {
        vm.stopScan()
      } label: {
        Text("stop scan")
      }
      
      Spacer()
      
      Button {
        vm.disconnect()
      } label: {
        Text("disconnect")
      }
      
      Spacer()
    }
    .padding()
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainScreen()
  }
}

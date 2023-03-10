//
//  AtfleeBluetoothStateType+Extension.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/24.
//

import Foundation
import AtfleeKit

extension AtfleeBluetoothStateType {
  var label: String {
    switch (self) {
      case .unknown:
        return "unknown"
      case .unsupported:
        return "unsupported"
      case .unauthorized:
        return "unauthorized"
      case .poweredOff:
        return "poweredOff"
      case .poweredOn:
        return "poweredOn"
      @unknown default:
        fatalError()
    }
  }
}

//
//  AtfleeBluetoothState.swift
//  AtfleeKit
//
//  Created by Ming on 2023/03/06.
//

import Foundation
import AtfleeBaseKit

public enum AtfleeBluetoothStateType {
  case unknown
  case unsupported
  case unauthorized
  case poweredOff
  case poweredOn
  
  internal static func fromICBleState(_ state: ICBleState) -> AtfleeBluetoothStateType {
    switch state {
      case .unknown:
        return .unknown
      case .unsupported:
        return .unsupported
      case .unauthorized:
        return .unauthorized
      case .poweredOff:
        return .poweredOff
      case .poweredOn:
        return .poweredOn
      @unknown default:
        fatalError()
    }
  }
}

//
//  AtfleeConnectionStateType.swift
//  AtfleeKit
//
//  Created by Ming on 2023/03/06.
//

import Foundation
import AtfleeBaseKit

public enum AtfleeConnectionStateType {
  case connecting
  case connected
  case disconnected
  
  static func fromICDeviceConnectState(_ state: ICDeviceConnectState) -> AtfleeConnectionStateType {
    switch state {
      case .connected:
        return .connected
      case .disconnected:
        return .disconnected
      @unknown default:
        fatalError()
    }
  }
}

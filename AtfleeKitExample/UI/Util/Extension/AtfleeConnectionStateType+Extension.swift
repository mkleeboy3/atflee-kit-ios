//
//  AtfleeConnectionStateType+Extension.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/24.
//

import Foundation
import AtfleeKit

extension AtfleeConnectionStateType {
  var label: String {
    switch (self) {
      case .disconnected:
        return "disconnected"
        
      case .connected:
        return "connected"
        
      case .connecting:
        return "connecting"
        
      @unknown default:
        fatalError()
    }
  }
}

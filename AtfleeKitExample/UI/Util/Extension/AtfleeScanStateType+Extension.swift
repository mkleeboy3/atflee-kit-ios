//
//  AtfleeScanStateType+Extension.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/24.
//

import Foundation
import AtfleeKit

extension AtfleeScanStateType {
  var label: String {
    switch (self) {
      case .scanning:
        return "scanning"
        
      case .notScanning:
        return "notScanning"
        
      @unknown default:
        fatalError()
    }
  }
}

//
//  AtfleeScanStateType.swift
//  AtfleeKit
//
//  Created by Ming on 2023/03/03.
//

import Foundation

public enum AtfleeScanStateType {
  case scanning
  case notScanning
  
  internal var isScanning: Bool {
    switch (self) {
      case .scanning:
        return true
        
      case .notScanning:
        return false
    }
  }
}

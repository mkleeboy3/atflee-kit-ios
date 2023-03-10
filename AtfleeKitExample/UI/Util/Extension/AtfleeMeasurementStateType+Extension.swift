//
//  AtfleeMeasurementStateType+Extension.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/03/06.
//

import Foundation
import AtfleeKit

extension AtfleeMeasurementStateType {
  var label: String {
    switch self {
      case .idle:
        return "idle"
        
      case .unstableWeight:
        return "unstable weight"
        
      case .startingAnalysis:
        return "starting analysis"
        
      case .analysisComplete:
        return "analysis complete"
        
      case .measurementComplete:
        return "measurement complete"
    }
  }
}

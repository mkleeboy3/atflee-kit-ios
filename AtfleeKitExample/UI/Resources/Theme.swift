//
//  Theme.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/09.
//

import Foundation
import SwiftUI

struct AppTheme {
  static let defaultAnimationSpeed: Double = 0.2
  static let defaultCursorAnimationSpeed: Double = 0.6
  static let testAnimationSpeed: Double = 5.0
  
  static let defaultAnimation = Animation.easeInOut(duration: defaultAnimationSpeed)
  static let defaultCursorAnimation = Animation.spring(response: 0.2, dampingFraction: 1.0)
  static let testAnimation = Animation.easeInOut(duration: testAnimationSpeed)
}

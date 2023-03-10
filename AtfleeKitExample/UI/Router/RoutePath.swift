//
//  RoutePath.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/20.
//

import Foundation
import SwiftUI

enum RoutePath: String, Hashable {
  case main = "/main"
  
  @ViewBuilder
  func buildScreenView(arg: Any?) -> some View {
    switch self {
      case .main:
        MainScreen()
    }
  }
}

//
//  ActivityProgressHelper.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/17.
//

import Foundation
import SwiftUI

class UIHelper: ObservableObject {
  static let shared = UIHelper()
  
  private(set) public var loading: Bool = false
  
  private init() {}
  
  func setLoading(_ loading: Bool) {
    self.loading = loading
    objectWillChange.send()
  }
}

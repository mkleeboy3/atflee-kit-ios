//
//  BottomNavigationTab.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/31.
//

import SwiftUI

protocol BottomNavigationTab: CaseIterable {
  associatedtype Content: View
  
  var id: Int { get }
  
  @ViewBuilder func buildScreenView() -> Content
  
  func getTabItemConfiguration() -> HDSBottomNavigation.TabItemConfiguration
}

//
//  PopupHelper.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/13.
//

import Foundation
import SwiftUI
import Combine

class PopupHelper: ObservableObject {
  static let shared: PopupHelper = PopupHelper()
  
  private(set) public var isShowingDialog: Bool = false
  private(set) public var dialogOptions: HDSDialogOptions?
  private(set) public var content: any View = EmptyView()
  
  private init() {}
  
  func showDialog<Content: View>(
    dialogOptions: HDSDialogOptions = HDSDialogOptions(),
    @ViewBuilder content: () -> Content = { EmptyView() }
  ) {
    guard !isShowingDialog else { return }
    
    isShowingDialog = true
    self.dialogOptions = dialogOptions
    self.content = content()
    objectWillChange.send()
  }
  
  func closeDialog() {
    guard isShowingDialog else { return }
    
    isShowingDialog = false
    self.dialogOptions = nil
    self.content = EmptyView()
    objectWillChange.send()
  }
}

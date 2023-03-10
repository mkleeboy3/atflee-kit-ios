//
//  ViewDidLoadModifier.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/10.
//

import SwiftUI

extension View {
  func onLoad(perform action: (() async -> Void)? = nil) -> some View {
    modifier(ViewDidLoadModifier(perform: action))
  }
}

struct ViewDidLoadModifier: ViewModifier {
  @State private var didLoad = false
  private let task: (() async -> Void)?
  
  init(perform task: (() async -> Void)? = nil) {
    self.task = task
  }
  
  func body(content: Content) -> some View {
    content.onAppear {
      Task {
        if didLoad == false {
          didLoad = true
          await task?()
        }
      }
    }
  }
}

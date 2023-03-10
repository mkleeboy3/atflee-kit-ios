//
//  ConditionalView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/13.
//

import SwiftUI

struct ConditionalView<TrueContent: View, FalseContent: View>: View {
  let condition: Bool
  let trueContent: TrueContent?
  let falseContent: FalseContent?
  
  init(
    _ condition: Bool,
    @ViewBuilder trueContent: @escaping () -> TrueContent = { EmptyView() },
    @ViewBuilder falseContent: @escaping () -> FalseContent = { EmptyView() }
  ) {
    self.condition = condition
    self.trueContent = condition ? trueContent() : nil
    self.falseContent = condition ? nil : falseContent()
  }
  
  var body: some View {
    ZStack {
      if (condition) {
        trueContent
      } else {
        falseContent
      }
    }
  }
}

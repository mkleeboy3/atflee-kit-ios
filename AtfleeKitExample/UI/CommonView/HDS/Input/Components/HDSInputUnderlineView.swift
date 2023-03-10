//
//  HDSTextFieldUnderlineView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/27.
//

import SwiftUI

struct HDSInputUnderlineView: View {
  let focused: Bool
  let error: Bool
  let unfocusedColor: Color
  let focusedColor: Color
  let errorColor: Color
  
  init(
    focused: Bool,
    error: Bool,
    unfocusedColor: Color = Palette.gray500,
    focusedColor: Color = Palette.primary500,
    errorColor: Color = Palette.feedbackRed500
  ) {
    self.focused = focused
    self.error = error
    self.unfocusedColor = unfocusedColor
    self.focusedColor = focusedColor
    self.errorColor = errorColor
  }
  
  var body: some View {
    Rectangle()
      .frame(height: 1)
      .foregroundColor(
        error ? errorColor :
          focused ? focusedColor : unfocusedColor
      )
      .animation(AppTheme.defaultAnimation, value: focused)
      .animation(AppTheme.defaultAnimation, value: error)
  }
}

//
//  HDSTextFieldLabelView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/27.
//

import SwiftUI

struct HDSInputLabelView: View {
  let label: String?
  let focused: Bool
  let error: Bool
  let unfocusedColor: Color
  let focusedColor: Color
  let errorColor: Color
  
  init(
    label: String? = nil,
    focused: Bool,
    error: Bool,
    unfocusedColor: Color = Palette.gray800,
    focusedColor: Color = Palette.primary500,
    errorColor: Color = Palette.feedbackRed500
  ) {
    self.label = label
    self.focused = focused
    self.error = error
    self.unfocusedColor = unfocusedColor
    self.focusedColor = focusedColor
    self.errorColor = errorColor
  }
  
  var body: some View {
    Text(label ?? "")
      .customFont(
        Fonts.detail4.copyWith(
          color: error ? errorColor :
            focused ? focusedColor : unfocusedColor
        )
      )
      .animation(AppTheme.defaultAnimation, value: focused)
      .animation(AppTheme.defaultAnimation, value: error)
  }
}

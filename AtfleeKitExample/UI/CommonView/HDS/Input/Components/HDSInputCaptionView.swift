//
//  HDSTextFieldCaptionView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/27.
//

import SwiftUI

struct HDSInputCaptionView: View {
  let hasShakeAnimation: Bool
  let focused: Bool
  let error: Bool
  let captionLabel: String?
  let errorCaptionLabel: String?
  let unfocusedColor: Color
  let focusedColor: Color
  let errorColor: Color
  
  init(
    hasShakeAnimation: Bool = true,
    focused: Bool,
    error: Bool,
    captionLabel: String?,
    errorCaptionLabel: String?,
    unfocusedColor: Color = Palette.transparent,
    focusedColor: Color = Palette.primary500,
    errorColor: Color = Palette.feedbackRed500
  ) {
    self.hasShakeAnimation = hasShakeAnimation
    self.focused = focused
    self.error = error
    self.captionLabel = captionLabel
    self.errorCaptionLabel = errorCaptionLabel
    self.unfocusedColor = unfocusedColor
    self.focusedColor = focusedColor
    self.errorColor = errorColor
  }
  
  var body: some View {
    let shouldShake = hasShakeAnimation && error && (errorCaptionLabel != nil)
    
    return HDSShakeAnimationView(shake: shouldShake) {
      Text(error ? (errorCaptionLabel ?? "") : (captionLabel ?? ""))
        .customFont(Fonts.detail4.copyWith(
          color: error ? errorColor :
            focused ? focusedColor : unfocusedColor
        ))
        .frame(height: 24)
        .animation(AppTheme.defaultAnimation, value: focused)
        .animation(AppTheme.defaultAnimation, value: error)
    }
  }
}

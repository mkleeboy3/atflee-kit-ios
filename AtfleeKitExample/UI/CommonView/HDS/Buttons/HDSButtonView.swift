//
//  HDSRectangleLargeButtonView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/01.
//

import SwiftUI

struct HDSButtonView: View {
  let width: CGFloat?
  let height: CGFloat?
  let disabled: Bool
  let label: String
  let labelFont: CustomFont
  let labelPressedFont: CustomFont
  let labelDisabledFont: CustomFont
  let color: Color
  let pressedColor: Color
  let disabledColor: Color
  let contentVerticalPadding: CGFloat
  let contentHorizontalPadding: CGFloat
  let cornerRadius: CGFloat
  let onPressed: VoidCallback?
  
  init(
    width: CGFloat? = nil,
    height: CGFloat? = nil,
    disabled: Bool,
    label: String,
    labelFont: CustomFont,
    labelPressedFont: CustomFont,
    labelDisabledFont: CustomFont,
    color: Color,
    pressedColor: Color,
    disabledColor: Color,
    contentVerticalPadding: CGFloat,
    contentHorizontalPadding: CGFloat,
    cornerRadius: CGFloat,
    onPressed: VoidCallback? = nil
  ) {
    self.width = width
    self.height = height
    self.disabled = disabled
    self.label = label
    self.labelFont = labelFont
    self.labelPressedFont = labelPressedFont
    self.labelDisabledFont = labelDisabledFont
    self.color = color
    self.pressedColor = pressedColor
    self.disabledColor = disabledColor
    self.contentVerticalPadding = contentVerticalPadding
    self.contentHorizontalPadding = contentHorizontalPadding
    self.cornerRadius = cornerRadius
    self.onPressed = onPressed
  }
  
  var body: some View {
    Button {
      onPressed?()
    } label: {
      Text(label)
        .padding(.vertical, contentVerticalPadding)
        .padding(.horizontal, contentHorizontalPadding)
        .frame(
          minWidth: 0,
          maxWidth: width,
          minHeight: 0,
          maxHeight: height
        )
    }
    .buttonStyle(
      HDSButtonStyle(
        disabled: disabled,
        labelFont: labelFont,
        labelPressedFont: labelPressedFont,
        labelDisabledFont: labelDisabledFont,
        color: color,
        pressedColor: pressedColor,
        disabledColor: disabledColor,
        cornerRadius: cornerRadius
      )
    )
  }
}

// - MARK: Button Style
fileprivate struct HDSButtonStyle: ButtonStyle {
  let disabled: Bool
  let labelFont: CustomFont
  let labelPressedFont: CustomFont
  let labelDisabledFont: CustomFont
  let color: Color
  let pressedColor: Color
  let disabledColor: Color
  let cornerRadius: CGFloat
  
  func makeBody(configuration: Configuration) -> some View {
    let pressed = configuration.isPressed
    configuration.label
      .customFont(
        disabled ? labelDisabledFont :
          pressed ? labelPressedFont : labelFont
      )
      .background(
        disabled ? disabledColor :
          pressed ? pressedColor : color
      )
      .cornerRadius(cornerRadius)
      .animation(AppTheme.defaultAnimation, value: disabled)
      .animation(AppTheme.defaultAnimation, value: pressed)
  }
}

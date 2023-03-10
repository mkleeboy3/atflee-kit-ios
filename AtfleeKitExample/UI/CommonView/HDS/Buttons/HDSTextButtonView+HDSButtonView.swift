//
//  HDSTextButtonView+HDSButtonView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/01.
//

import SwiftUI

extension HDSButtonView {
  @ViewBuilder
  static func text(
    width: CGFloat? = nil,
    height: CGFloat? = nil,
    disabled: Bool,
    label: String,
    labelFont: CustomFont = Fonts.detail4.copyWith(color: Palette.primary500),
    labelPressedFont: CustomFont = Fonts.detail4.copyWith(color: Palette.primary500),
    labelDisabledFont: CustomFont = Fonts.detail4.copyWith(color: Palette.gray600),
    color: Color = Palette.transparent,
    pressedColor: Color = Palette.gray100,
    disabledColor: Color = Palette.transparent,
    contentVerticalPadding: CGFloat = 4,
    contentHorizontalPadding: CGFloat = 12,
    cornerRadius: CGFloat = 12,
    onPressed: VoidCallback? = nil
  ) -> some View {
    self.init(
      width: width,
      height: height,
      disabled: disabled,
      label: label,
      labelFont: labelFont,
      labelPressedFont: labelPressedFont,
      labelDisabledFont: labelDisabledFont,
      color: color,
      pressedColor: pressedColor,
      disabledColor: disabledColor,
      contentVerticalPadding: contentVerticalPadding,
      contentHorizontalPadding: contentHorizontalPadding,
      cornerRadius: cornerRadius,
      onPressed: onPressed
    )
  }
}

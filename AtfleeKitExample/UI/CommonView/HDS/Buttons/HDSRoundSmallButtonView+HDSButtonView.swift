//
//  HDSRoundSmallButtonView+HDSButtonView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/01.
//

import SwiftUI

extension HDSButtonView {
  @ViewBuilder
  static func roundSmallBasic(
    width: CGFloat? = nil,
    height: CGFloat? = nil,
    disabled: Bool,
    label: String,
    labelFont: CustomFont = Fonts.body1.copyWith(color: Palette.white100Percent),
    labelPressedFont: CustomFont = Fonts.body1.copyWith(color: Palette.white100Percent),
    labelDisabledFont: CustomFont = Fonts.body1.copyWith(color: Palette.gray600),
    color: Color = Palette.primary500,
    pressedColor: Color = Palette.primary300,
    disabledColor: Color = Palette.gray100,
    contentVerticalPadding: CGFloat = 8,
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
  
  @ViewBuilder
  static func roundSmallCancel(
    width: CGFloat? = nil,
    height: CGFloat? = nil,
    label: String,
    labelFont: CustomFont = Fonts.body1.copyWith(color: Palette.gray900),
    labelPressedFont: CustomFont = Fonts.body1.copyWith(color: Palette.gray900),
    color: Color = Palette.gray100,
    pressedColor: Color = Palette.gray200,
    contentVerticalPadding: CGFloat = 8,
    contentHorizontalPadding: CGFloat = 12,
    cornerRadius: CGFloat = 12,
    onPressed: VoidCallback? = nil
  ) -> some View {
    self.init(
      width: width,
      height: height,
      disabled: false,
      label: label,
      labelFont: labelFont,
      labelPressedFont: labelPressedFont,
      labelDisabledFont: labelFont,
      color: color,
      pressedColor: pressedColor,
      disabledColor: color,
      contentVerticalPadding: contentVerticalPadding,
      contentHorizontalPadding: contentHorizontalPadding,
      cornerRadius: cornerRadius,
      onPressed: onPressed
    )
  }
}

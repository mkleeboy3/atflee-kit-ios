//
//  HDSIconButtonView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/01.
//

import SwiftUI

struct HDSIconButtonView: View {
  let iconSize: CGSize
  let width: CGFloat?
  let height: CGFloat?
  let disabled: Bool
  let iconAsset: String
  let pressedIconAsset: String
  let color: Color
  let pressedColor: Color
  let disabledColor: Color
  let contentVerticalPadding: CGFloat
  let contentHorizontalPadding: CGFloat
  let cornerRadius: CGFloat
  let onPressed: VoidCallback?
  
  init(
    iconSize: CGSize,
    width: CGFloat? = nil,
    height: CGFloat? = nil,
    disabled: Bool,
    iconAsset: String,
    pressedIconAsset: String,
    color: Color = Palette.transparent,
    pressedColor: Color = Palette.gray100,
    disabledColor: Color = Palette.transparent,
    contentVerticalPadding: CGFloat = 12,
    contentHorizontalPadding: CGFloat = 12,
    cornerRadius: CGFloat = 12,
    onPressed: VoidCallback?
  ) {
    self.iconSize = iconSize
    self.width = width
    self.height = height
    self.disabled = disabled
    self.iconAsset = iconAsset
    self.pressedIconAsset = pressedIconAsset
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
      EmptyView()
    }
    .buttonStyle(
      HDSIconButtonStyle(
        iconSize: iconSize,
        width: width,
        height: height,
        disabled: disabled,
        iconAsset: iconAsset,
        pressedIconAsset: pressedIconAsset,
        color: color,
        pressedColor: pressedColor,
        disabledColor: disabledColor,
        contentVerticalPadding: contentVerticalPadding,
        contentHorizontalPadding: contentHorizontalPadding,
        cornerRadius: cornerRadius,
        onPressed: onPressed
      )
    )
  }
}

// - MARK: Button Style
fileprivate struct HDSIconButtonStyle: ButtonStyle {
  let iconSize: CGSize
  let width: CGFloat?
  let height: CGFloat?
  let disabled: Bool
  let iconAsset: String
  let pressedIconAsset: String
  let color: Color
  let pressedColor: Color
  let disabledColor: Color
  let contentVerticalPadding: CGFloat
  let contentHorizontalPadding: CGFloat
  let cornerRadius: CGFloat
  let onPressed: VoidCallback?
  
  func makeBody(configuration: Configuration) -> some View {
    let pressed = configuration.isPressed
    
    ZStack {
      Image(iconAsset)
        .resizable()
        .scaledToFit()
        .opacity((pressed && !disabled) ? 0 : 1)
      
      Image(pressedIconAsset)
        .resizable()
        .scaledToFit()
        .opacity(pressed ? 1 : 0)
        .opacity(disabled ? 0 : 1)
    }
    .frame(width: iconSize.width, height: iconSize.height)
    .padding(.vertical, contentVerticalPadding)
    .padding(.horizontal, contentHorizontalPadding)
    .frame(
      minWidth: 0,
      maxWidth: width,
      minHeight: 0,
      maxHeight: height
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

//
//  HDSFloatingButtonView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/02.
//

import SwiftUI

struct HDSFloatingButtonView: View {
  let iconSize: CGSize
  let disabled: Bool
  let iconAsset: String
  let pressedIconAsset: String
  let disabledIconAsset: String
  let color: Color
  let pressedColor: Color
  let disabledColor: Color
  let contentPadding: CGFloat
  let hasShadow: Bool
  let onPressed: VoidCallback?
  
  init(
    iconSize: CGSize,
    disabled: Bool,
    iconAsset: String,
    pressedIconAsset: String? = nil,
    disabledIconAsset: String?,
    color: Color = Palette.primary500,
    pressedColor: Color = Palette.primary300,
    disabledColor: Color = Palette.white100Percent,
    contentPadding: CGFloat = 20,
    hasShadow: Bool = true,
    onPressed: VoidCallback? = nil
  ) {
    self.iconSize = iconSize
    self.disabled = disabled
    self.iconAsset = iconAsset
    self.pressedIconAsset = pressedIconAsset ?? iconAsset
    self.disabledIconAsset = disabledIconAsset ?? iconAsset
    self.color = color
    self.pressedColor = pressedColor
    self.disabledColor = disabledColor
    self.contentPadding = contentPadding
    self.hasShadow = hasShadow
    self.onPressed = onPressed
  }
  
  var body: some View {
    Button {
      onPressed?()
    } label: {
      EmptyView()
    }
    .buttonStyle(
      HDSFloatingButtonStyle(
        iconSize: iconSize,
        disabled: disabled,
        iconAsset: iconAsset,
        pressedIconAsset: pressedIconAsset,
        disabledIconAsset: disabledIconAsset,
        color: color,
        pressedColor: pressedColor,
        disabledColor: disabledColor,
        contentPadding: contentPadding,
        hasShadow: hasShadow,
        onPressed: onPressed
      )
    )
  }
}

// - MARK: Button Style
fileprivate struct HDSFloatingButtonStyle: ButtonStyle {
  let iconSize: CGSize
  let disabled: Bool
  let iconAsset: String
  let pressedIconAsset: String
  let disabledIconAsset: String
  let color: Color
  let pressedColor: Color
  let disabledColor: Color
  let contentPadding: CGFloat
  let hasShadow: Bool
  let onPressed: VoidCallback?
  
  func makeBody(configuration: Configuration) -> some View {
    let pressed = configuration.isPressed
    
    ZStack {
      Circle()
        .frame(
          width: iconSize.width + contentPadding,
          height: iconSize.height + contentPadding
        )
        .foregroundColor(
          disabled ? disabledColor :
            pressed ? pressedColor : color
        )
        .if(
          hasShadow,
          transform: { view in
            // TODO: Shadow 스타일 추후 변경 될 예정
            view
              .shadow(color: Palette.shadowBlack20Percent, radius: 4, x: 0, y: 2)
              .shadow(color: Palette.shadowBlack12Percent, radius: 10, x: 0, y: 1)
              .shadow(color: Palette.shadowBlack14Percent, radius: 5, x: 0, y: 4)
          }
        )
      
      ZStack {
        Image(iconAsset)
          .resizable()
          .scaledToFit()
          .opacity(pressed ? 0 : 1)
          .opacity(disabled ? 0 : 1)
        
        Image(pressedIconAsset)
          .resizable()
          .scaledToFit()
          .opacity(pressed ? 1 : 0)
          .opacity(disabled ? 0 : 1)
        
        Image(disabledIconAsset)
          .resizable()
          .scaledToFit()
          .opacity(disabled ? 1 : 0)
      }
      .frame(width: iconSize.width, height: iconSize.height)
    }
    .animation(AppTheme.defaultAnimation, value: disabled)
    .animation(AppTheme.defaultAnimation, value: pressed)
  }
}

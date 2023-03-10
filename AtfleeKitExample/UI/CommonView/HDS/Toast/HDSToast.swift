//
//  HDSToast.swift
//  AtfleeKitExample
//
//  Created by wy.jeon on 2023/02/09.
//

import SwiftUI

extension View {
  func toast(
    isShowingToast: Bool,
    toastOptions: HDSToastOptions?,
    toastString: String?
  ) -> some View {
    modifier(
      HDSToast(
        isShowingToast: isShowingToast,
        toastOptions: toastOptions,
        toastString: toastString
      )
    )
  }
}

struct HDSToast: ViewModifier {  
  let isShowingToast: Bool
  let toastOptions: HDSToastOptions?
  let toastString: String?
  
  init(
    isShowingToast: Bool,
    toastOptions: HDSToastOptions?,
    toastString: String?
  ) {
    self.isShowingToast = isShowingToast
    self.toastOptions = toastOptions
    self.toastString = toastString
  }
  
  func body(content: Content) -> some View {
    ZStack {
      content
      
      toastView
    }
  }
  
  private var toastView: some View {
    ConditionalView(
      isShowingToast && (toastString != nil) && (toastOptions != nil),
      trueContent: {
        VStack(spacing: 0) {
          Spacer()
          
          Text(toastString!)
            .customFont(toastOptions!.font)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, minHeight: 0)
            .background(toastOptions!.backgroundColor)
            .cornerRadius(toastOptions!.cornerRadius)
        }
        .padding(.horizontal, toastOptions!.toastHorizontalMargin)
        .padding(.bottom, toastOptions!.toastBottomMargin)
      }
    )
    .animation(AppTheme.defaultAnimation, value: isShowingToast)
  }
}

struct HDSToastOptions {
  let cornerRadius: CGFloat
  let font: CustomFont
  let labelColor: Color
  let backgroundColor: Color
  let toastVerticalPadding: CGFloat
  let toastHorizontalPadding: CGFloat
  let toastHorizontalMargin: CGFloat
  let toastBottomMargin: CGFloat
  
  init(
    cornerRadius: CGFloat = 12,
    font: CustomFont = Fonts.body1.copyWith(color: Palette.white100Percent),
    labelColor: Color = Palette.white100Percent,
    backgroundColor: Color = Palette.black90Percent,
    toastVerticalPadding: CGFloat = 12,
    toastHorizontalPadding: CGFloat = 16,
    toastHorizontalMargin: CGFloat = 16,
    toastBottomMargin: CGFloat = 40
  ) {
    self.cornerRadius = cornerRadius
    self.font = font
    self.labelColor = labelColor
    self.backgroundColor = backgroundColor
    self.toastVerticalPadding = toastVerticalPadding
    self.toastHorizontalPadding = toastHorizontalPadding
    self.toastHorizontalMargin = toastHorizontalMargin
    self.toastBottomMargin = toastBottomMargin
  }
}

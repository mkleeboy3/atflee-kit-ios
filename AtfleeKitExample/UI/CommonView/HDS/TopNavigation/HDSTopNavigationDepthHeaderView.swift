//
//  HDSTopNavigationDepthHeaderView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/15.
//

import SwiftUI

struct HDSTopNavigationDepthHeaderView: View {
  let hasScaleAnimationOnDrag: Bool
  let scaleFactor: CGFloat
  let headerHeight: CGFloat
  let headerHorizontalPadding: CGFloat
  let titleLabel: String
  let font: CustomFont
  
  init(
    hasScaleAnimationOnDrag: Bool = true,
    scaleFactor: CGFloat,
    headerHeight: CGFloat,
    headerHorizontalPadding: CGFloat = 24,
    titleLabel: String,
    font: CustomFont = Fonts.title1
  ) {
    self.hasScaleAnimationOnDrag = hasScaleAnimationOnDrag
    self.scaleFactor = scaleFactor
    self.headerHeight = headerHeight
    self.headerHorizontalPadding = headerHorizontalPadding
    self.titleLabel = titleLabel
    self.font = font
  }
  
  var body: some View {
    HStack {
      Text(titleLabel)
        .customFont(font)
        .if(
          hasScaleAnimationOnDrag,
          transform: { view in
            view
              .scaleEffect(
                scaleFactor,
                anchor: .bottomLeading
              )
              .animation(AppTheme.defaultAnimation, value: scaleFactor)
          }
        )
          .animation(AppTheme.defaultAnimation, value: titleLabel)
            
            Spacer()
    }
    .frame(height: 31)
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 24)
  }
}

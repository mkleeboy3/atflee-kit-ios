//
//  HDSTopNavigationBasicView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/30.
//

import SwiftUI

struct HDSTopNavigationView<LeadingContent: View, TrailingContent: View>: View {
  let router = Router.shared
  
  private let toolbarHeight: CGFloat = 56
  
  let showDefaultLeadingButton: Bool
  let titleLabel: String?
  let titleFont: CustomFont
  let titleVisible: Bool
  let backgroundColor: Color
  let leftMargin: CGFloat
  let rightMargin: CGFloat
  let leadingContent: LeadingContent
  let trailingContent: TrailingContent
  
  init(
    showDefaultLeadingButton: Bool = true,
    titleLabel: String? = nil,
    titleFont: CustomFont = Fonts.body1,
    titleVisible: Bool = true,
    backgroundColor: Color = Palette.white100Percent,
    leftMargin: CGFloat = 16,
    rightMargin: CGFloat = 16,
    @ViewBuilder leadingContent: @escaping () -> LeadingContent = { EmptyView() },
    @ViewBuilder trailingContent: @escaping () -> TrailingContent = { EmptyView() }
  ) {
    self.showDefaultLeadingButton = showDefaultLeadingButton
    self.titleLabel = titleLabel
    self.titleFont = titleFont
    self.titleVisible = titleVisible
    self.backgroundColor = backgroundColor
    self.leftMargin = leftMargin
    self.rightMargin = rightMargin
    self.leadingContent = leadingContent()
    self.trailingContent = trailingContent()
  }
  
  var body: some View {
    ZStack {
      HStack {
        SizedView(width: leftMargin)
        
        ConditionalView(
          showDefaultLeadingButton,
          trueContent: {
            defaultLeadingButtonView
          },
          falseContent: {
            leadingContent
          }
        )
        
        Spacer()
        
        trailingContent
        
        SizedView(width: rightMargin)
      }
      .frame(height: toolbarHeight)
      .background(backgroundColor)
      
      ConditionalView(
        titleVisible && (titleLabel != nil),
        trueContent: {
          Text(titleLabel!)
            .customFont(titleFont)
        }
      )
      .animation(AppTheme.defaultAnimation, value: titleVisible)
      .animation(AppTheme.defaultAnimation, value: (titleLabel != nil))
    }
  }
}

extension HDSTopNavigationView {
  var defaultLeadingButtonView: some View {
    Button {
      router.pop()
    } label: {
      Image(Assets.leadingButton)
        .resizable()
        .scaledToFit()
        .frame(width: 24, height: 24)
    }
  }
}

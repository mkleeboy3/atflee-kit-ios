//
//  ScreenView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/13.
//

import SwiftUI

struct ScreenView<TopNavigation: View, Content: View>: View {
  @EnvironmentObject var safeAreaInsets: SafeAreaInsets
  
  let uiHelper = UIHelper.shared
  
  let topSafeAreaColor: Color
  let bottomSafeAreaColor: Color
  let hasTopSafeArea: Bool
  let hasBottomSafeArea: Bool
  let backgroundColor: Color
  
  let topNavigationContent: TopNavigation
  let content: Content
  
  init(
    topSafeAreaColor: Color = Palette.white100Percent,
    bottomSafeAreaColor: Color = Palette.white100Percent,
    hasTopSafeArea: Bool = true,
    hasBottomSafeArea: Bool = true,
    backgroundColor: Color = Palette.white100Percent,
    @ViewBuilder topNavigationContent: @escaping () -> TopNavigation = { EmptyView() },
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.topSafeAreaColor = topSafeAreaColor
    self.bottomSafeAreaColor = bottomSafeAreaColor
    self.hasTopSafeArea = hasTopSafeArea
    self.hasBottomSafeArea = hasBottomSafeArea
    self.backgroundColor = backgroundColor
    self.topNavigationContent = topNavigationContent()
    self.content = content()
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        buildMainContentView(
          topInset: geometry.safeAreaInsets.top,
          bottomInset: geometry.safeAreaInsets.bottom
        )
        
        ConditionalView(
          uiHelper.loading,
          trueContent: {
            activityProgressView
          }
        )
      }
    }
  }
}

extension ScreenView {
  var activityProgressView: some View {
    ZStack {
      Rectangle()
        .fill(Palette.black01Basic.opacity(0.26))
      
      EmptyView()
        .frame(width: 60, height: 60)
    }
    .ignoresSafeArea(.all)
  }
}

extension ScreenView {
  @ViewBuilder
  func buildMainContentView(
    topInset: CGFloat,
    bottomInset: CGFloat
  ) -> some View {
    VStack(spacing: 0) {
      ConditionalView(
        hasTopSafeArea,
        trueContent: {
          Rectangle()
            .frame(height: topInset)
            .foregroundColor(topSafeAreaColor)
        }
      )
      
      topNavigationContent
      
      content
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
      
      ConditionalView(
        hasBottomSafeArea,
        trueContent: {
          Rectangle()
            .frame(height: bottomInset)
            .foregroundColor(bottomSafeAreaColor)
        }
      )
    }.ignoresSafeArea(.all)
  }
}

//
//  ListenableScrollView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/15.
//

import SwiftUI

struct ListenableScrollView<Content: View>: View {
  @Namespace var listenableSpace
  
  let content: Content
  let onScroll: ((CGFloat) -> ())?
  
  init(
    @ViewBuilder content: @escaping () -> Content,
    onScroll: ((CGFloat) -> ())? = nil
  ) {
    self.content = content()
    self.onScroll = onScroll
  }
  
  var body: some View {
    ScrollView {
      offsetReader
      
      content
        .padding(.top, -8)
    }
    .coordinateSpace(name: listenableSpace)
    .onPreferenceChange(OffsetPreferenceKey.self) { offset in
      let offset = (offset == 0) ? 0 : -offset
      onScroll?(offset)
    }
  }
  
  var offsetReader: some View {
    GeometryReader { proxy in
      Palette.transparent
        .preference(
          key: OffsetPreferenceKey.self,
          value: proxy.frame(in: .named(listenableSpace)).minY
        )
    }
    .frame(height: 0)
  }
}

fileprivate struct OffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = 0
  
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value += nextValue()
  }
}

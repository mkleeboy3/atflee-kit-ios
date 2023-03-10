//
//  CustomFont+ViewModifier.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/26.
//

import SwiftUI

extension View {
  func customFont(_ customFont: CustomFont) -> some View {
    modifier(customFont)
  }
}

extension CustomFont: ViewModifier {
  func body(content: Content) -> some View {
    let font = UIFont(name: name, size: size)!
    let lineHeight = size * lineHeightProportion
    
    return content
      .font(Font(font))
      .lineSpacing(lineHeight - font.lineHeight)
      .padding(.vertical, (lineHeight - font.lineHeight) / 2)
      .foregroundColor(color)
  }
}

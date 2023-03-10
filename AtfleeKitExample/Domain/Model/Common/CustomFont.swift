//
//  CustomFont.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/26.
//

import Foundation
import SwiftUI

struct CustomFont {
  let name: String
  let size: CGFloat
  let color: Color
  let lineHeightProportion: CGFloat
  
  init(
    name: String,
    size: CGFloat,
    color: Color = Palette.black100Percent,
    lineHeightProportion: CGFloat
  ) {
    self.name = name
    self.size = size
    self.color = color
    self.lineHeightProportion = lineHeightProportion
  }
  
  func copyWith(
    name: String? = nil,
    size: CGFloat? = nil,
    color: Color? = nil,
    lineHeightProportion: CGFloat? = nil
  ) -> CustomFont {
    CustomFont(
      name: name ?? self.name,
      size: size ?? self.size,
      color: color ?? self.color,
      lineHeightProportion: lineHeightProportion ?? self.lineHeightProportion
    )
  }
  
  func toUIFont() -> UIFont {
    UIFont(
      name: name,
      size: size
    )!
  }
}

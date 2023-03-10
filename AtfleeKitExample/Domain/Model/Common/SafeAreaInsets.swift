//
//  SafeAreaInsets.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/10.
//

import Foundation

class SafeAreaInsets: ObservableObject {
  let leading: CGFloat
  let top: CGFloat
  let trailing: CGFloat
  let bottom: CGFloat
  
  init(
    leading: CGFloat,
    top: CGFloat,
    trailing: CGFloat,
    bottom: CGFloat
  ) {
    self.leading = leading
    self.top = top
    self.trailing = trailing
    self.bottom = bottom
  }
}

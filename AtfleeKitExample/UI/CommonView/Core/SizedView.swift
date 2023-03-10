//
//  SizedView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/13.
//

import SwiftUI

struct SizedView: View {
  let width: CGFloat?
  let height: CGFloat?
  
  init(
    width: CGFloat? = nil,
    height: CGFloat? = nil
  ) {
    self.width = width
    self.height = height
  }
  
  var body: some View {
    Spacer()
      .frame(
        width: width,
        height: height
      )
  }
}

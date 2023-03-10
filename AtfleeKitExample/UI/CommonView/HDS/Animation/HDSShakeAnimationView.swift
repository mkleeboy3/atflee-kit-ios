//
//  HDSShakeAnimationView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/26.
//

import Foundation
import SwiftUI

struct HDSShakeAnimationView<Content: View>: View {
  let shake: Bool
  let shakes: Int
  let magnitude: Int
  let content: Content
  
  init(
    shake: Bool,
    shakes: Int = 2,
    magnitude: Int = 2,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.shake = shake
    self.shakes = shakes
    self.magnitude = magnitude
    self.content = content()
  }
  
  var body: some View {
    content
      .modifier(
        ShakeEffect(
          shakes: shake ? shakes : 0,
          magnitude: magnitude
        )
        .animation(AppTheme.defaultAnimation)
      )
  }
}

fileprivate struct ShakeEffect: GeometryEffect {
  private var position: CGFloat
  private let target: CGFloat
  private let magnitude: CGFloat
  
  var animatableData: CGFloat {
    get { position }
    set { position = newValue }
  }
  
  init(
    shakes: Int,
    magnitude: Int = 2
  ) {
    position = CGFloat(shakes)
    target = CGFloat(shakes)
    self.magnitude = CGFloat(magnitude)
  }
  
  func effectValue(size: CGSize) -> ProjectionTransform {
    let isAnimationReverse = (target <= position)
    if isAnimationReverse {
      return ProjectionTransform(
        CGAffineTransform(
          translationX: 0,
          y: 0
        )
      )
    }
    
    return ProjectionTransform(
      CGAffineTransform(
        translationX: -magnitude * cos(position * 2 * .pi),
        y: 0
      )
    )
  }
}

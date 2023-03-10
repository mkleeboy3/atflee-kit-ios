//
//  UIImage+UIView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/02.
//

import UIKit

extension UIView {
  func toUIImage() -> UIImage {
    let renderer = UIGraphicsImageRenderer(bounds: bounds)
    return renderer.image { rendererContext in
      layer.render(in: rendererContext.cgContext)
    }
  }
}

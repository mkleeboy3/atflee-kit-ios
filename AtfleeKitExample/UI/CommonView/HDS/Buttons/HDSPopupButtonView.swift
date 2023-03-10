//
//  HDSPopupButtonView.swift
//  AtfleeKitExample
//
//  Created by wy.jeon on 2023/02/09.
//

import SwiftUI

enum HDSPopupButtonType {
  case confirm
  case cancel
}

struct HDSPopupButtonView: View {
  private let popupButtonHeight: CGFloat = 59
  
  let disabled: Bool
  let title: String
  let type: HDSPopupButtonType?
  let onPressed: (() -> ())?
  
  init(
    disabled: Bool,
    title: String,
    type: HDSPopupButtonType? = .confirm,
    onPressed: (() -> ())? = nil
  ) {
    self.disabled = disabled
    self.title = title
    self.type = type
    self.onPressed = onPressed
  }
  
  var body: some View {
    view(type: type)
  }
  
  @ViewBuilder
  func view(type: HDSPopupButtonType?) -> some View {
    switch type {
      case .confirm:
        HDSButtonView.roundLargeBasic(
          width: .infinity,
          height: popupButtonHeight,
          disabled: disabled,
          label: title,
          contentHorizontalPadding: 10,
          onPressed: onPressed
        )
        
      case .cancel:
        HDSButtonView.roundLargeCancel(
          width: .infinity,
          height: popupButtonHeight,
          label: title,
          contentHorizontalPadding: 10,
          onPressed: onPressed
        )
        
      default:
        HDSButtonView.roundLargeBasic(
          width: .infinity,
          height: popupButtonHeight,
          disabled: disabled,
          label: title,
          contentHorizontalPadding: 10,
          onPressed: onPressed
        )
    }
  }
}

struct Previews_HDSPopupButtonView_Previews: PreviewProvider {
  
  static var previews: some View {
    VStack {
      HDSPopupButtonView(disabled: false, title: "Button Text", onPressed: {
        print("Click")
      })
      HDSPopupButtonView(disabled: true, title: "Button Text", type: .cancel, onPressed: {
        print("Click")
      })
      HDSPopupButtonView(disabled: true, title: "Button Text", onPressed: {
        print("Click")
      })
    }
  }
}


//
//  HDSBottomSheetView.swift
//  AtfleeKitExample
//
//  Created by wy.jeon on 2023/02/09.
//

import SwiftUI

struct HDSBottomSheetView<Content>: View where Content: View {
  @EnvironmentObject var safeAreaInsets: SafeAreaInsets
  
  private let popupCornerRadius: CGFloat = 16
  private let contentHorizontalPadding: CGFloat = 24
  
  let title: String
  let stringContent: String
  let buttons: [HDSPopupButtonView]
  var content: () -> Content
  
  var body: some View {
      VStack (spacing: .zero) {
        titleView
        subTitleView
        contentView
        buttonView
        
        SizedView(height: safeAreaInsets.bottom)
      }.padding(contentHorizontalPadding)
        .multilineTextAlignment(.center)
        .background(Color.white)
        .cornerRadius(popupCornerRadius)
        .shadow(
          color: Color.gray.opacity(0.1),
          radius: 8,
          x: 0,
          y: 0
        )
  }
}

private extension HDSBottomSheetView {
  
  var titleView: some View {
    Text(title)
      .customFont(Fonts.title1.copyWith(color: Color.black))
      .padding(.vertical, 8)
  }
  
  var subTitleView: some View {
    Text(stringContent)
      .customFont(Fonts.detail4.copyWith(color: Palette.gray800))
      .padding(.bottom, 36)
  }
  
  var contentView: some View {
    content()
  }
  
  var buttonView: some View {
    HStack(spacing: 8) {
      ForEach(buttons.indices, id: \.self) { index in
        if buttons[index].type == .cancel {
          buttons[index]
            .frame(width: (UIScreen.self.main.bounds.width - contentHorizontalPadding * 2) / 3)
        } else {
          buttons[index]
        }
      }
    }
  }
}


struct Previews_HDSBottomSheetView_Previews: PreviewProvider {
  
  @State static var selectionValue: Int = 0
  
  static var previews: some View {
    VStack {
      HDSBottomSheetView(title: "Title", stringContent: "Plz input something text.", buttons: [
        HDSPopupButtonView(disabled: false, title: "Button Sub", type: .cancel, onPressed: {
          print("Click")
        }),
        HDSPopupButtonView(disabled: false, title: "Button Main", onPressed: {
          print("Click")
        })
      ]) {
        Picker("Kind", selection: $selectionValue, content: {
          Text("Option").tag(0)
          Text("Option").tag(1)
          Text("Option").tag(2)
        })
        .padding(0)
        .pickerStyle(.wheel)
      }
    }
    .frame(
      maxWidth: .infinity,
      maxHeight: .infinity
    )
    .background(Palette.gray200)
    .ignoresSafeArea()
  }
}

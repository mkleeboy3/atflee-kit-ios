//
//  HDSSelectOptionListItemView.swift
//  AtfleeKitExample
//
//  Created by wy.jeon on 2023/02/10.
//

import SwiftUI

struct HDSSelectOptionListItemView: View {
  
  @Binding var selected: Bool
  
  let disabled: Bool?
  let label: String?
  let width: CGFloat?
  let height: CGFloat?
  let onPressed: VoidCallback?
  
  init(
    disabled: Bool? = false,
    selected: Binding<Bool>,
    label: String? = nil,
    width: CGFloat? = 170,
    height: CGFloat? = 51,
    onPressed: VoidCallback? = nil
  ) {
    self.disabled = disabled
    self._selected = selected
    self.label = label
    self.width = width
    self.height = height
    self.onPressed = onPressed
  }
  
  var body: some View {
    Button (action: {
      onPressed?()
    }){
      EmptyView()
    }
    .buttonStyle(
      HDSSelectOptionListItemStyle(
        disabled: disabled,
        selected: $selected,
        label: label,
        width: width,
        height: height
      )
    )
  }
}

fileprivate struct HDSSelectOptionListItemStyle: ButtonStyle {
  private let virticalPadding: CGFloat = 4
  private let horizontalPadding: CGFloat = 8
  
  let disabled: Bool?
  @Binding var selected: Bool
  let label: String?
  let width: CGFloat?
  let height: CGFloat?
  
  func makeBody(configuration: Configuration) -> some View {
    let pressed = configuration.isPressed
    let stateColor = getItemColor(disabled: disabled == true, selected: selected, pressed: pressed)
    
    HStack(spacing: 8){
      Image((selected || disabled == true) ? Assets.checkMarkWhite : Assets.checkMarkDisabled)
        .resizable()
        .scaledToFit()
        .frame(width: 24, height: 24)
      
      Text(label ?? "")
        .customFont(Fonts.body1.copyWith(
          color: stateColor.textColor
        ))
      
      Spacer()
    }
    .frame(width: width, height: height)
    .padding(.horizontal, 12)
    .background(stateColor.bgColor)
    .cornerRadius(12)
    .onTapGesture {
      if disabled == false {
        selected.toggle()
      }
    }
    
  }
  
  func getItemColor(disabled: Bool, selected: Bool, pressed: Bool) -> (textColor: Color, bgColor: Color) {
    if disabled == true {
      return (Palette.white01Basic.opacity(0.2), Palette.gray800)
    }
    
    if selected == true {
      return (Palette.white01Basic, Palette.primary500)
    }
    
    return (Palette.black01Basic, pressed ? Palette.gray200 : Palette.gray100)
  }
}

struct Previews_HDSSelectOptionListItemView_Previews: PreviewProvider {
  @State static var isSelectedFalse: Bool = false
  @State static var isSelectedTrue: Bool = true
  
  static var previews: some View {
    VStack {
      HDSSelectOptionListItemView(selected: $isSelectedFalse, label: "Text")
      HDSSelectOptionListItemView(selected: $isSelectedTrue, label: "Text")
      HDSSelectOptionListItemView(disabled: true, selected: $isSelectedTrue, label: "Text")
    }
  }
}


//
//  HDSBoxListItemView.swift
//  AtfleeKitExample
//
//  Created by wy.jeon on 2023/02/10.
//

import SwiftUI

struct HDSBoxListItemView: View {
  
  @Binding var isOn: Bool
  
  let label: String?
  let onLabel: String?
  let offLabel: String?
  let onColor: Color?
  let offColor: Color?
  let height: CGFloat?
  let onPressed: VoidCallback?
  
  init(
    isOn: Binding<Bool>,
    label: String? = nil,
    onLabel: String? = nil,
    offLabel: String? = nil,
    onColor: Color? = Palette.primary500,
    offColor: Color? = Palette.gray600,
    height: CGFloat? = 56,
    onPressed: VoidCallback? = nil
  ) {
    self._isOn = isOn
    self.label = label
    self.onLabel = onLabel
    self.offLabel = offLabel
    self.onColor = onColor
    self.offColor = offColor
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
      HDSBoxListItemStyle(
        isOn: $isOn,
        label: label,
        onLabel: onLabel,
        offLabel: offLabel,
        onColor: onColor,
        offColor: offColor,
        height: height
      )
    )
  }
}

fileprivate struct HDSBoxListItemStyle: ButtonStyle {
  @Binding var isOn: Bool
  let label: String?
  let onLabel: String?
  let offLabel: String?
  let onColor: Color?
  let offColor: Color?
  let height: CGFloat?
  
  func makeBody(configuration: Configuration) -> some View {
    HStack {

      HStack {
        Text(label ?? "")
          .customFont(Fonts.body1.copyWith(
            color: Palette.black01Basic
          ))
        
        Spacer()
        
        Text(isOn ? onLabel ?? "" : offLabel ?? "")
          .customFont(Fonts.body1.copyWith(
            color: isOn ? onColor : offColor
          ))
        
        HDSToggle(type: .basic, isOn: $isOn)
      }
    }
    .frame(height: height)
    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
    .background(Palette.gray100)
    .cornerRadius(12)
  }
}

struct Previews_HDSBoxListItemView_Previews: PreviewProvider {
  @State static var isOn: Bool = false

  static var previews: some View {
    VStack {
      HDSBoxListItemView(isOn: $isOn, label: "Text", onLabel: "ON", offLabel: "OFF")
    }
  }
}


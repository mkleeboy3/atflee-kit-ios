//
//  HDSListItemView.swift
//  AtfleeKitExample
//
//  Created by wy.jeon on 2023/02/05.
//

import SwiftUI

struct HDSListItemView: View {
  
  let label: String?
  let subLabel: String?
  let image: UIImage?
  let height: CGFloat?
  let toggle: HDSToggle?
  let onPressed: VoidCallback?
  
  init(
    label: String? = nil,
    subLabel: String? = nil,
    image: UIImage? = nil,
    height: CGFloat? = 80,
    toggle: HDSToggle? = nil,
    onPressed: VoidCallback? = nil
  ) {
    self.label = label
    self.subLabel = subLabel
    self.image = image
    self.height = height
    self.toggle = toggle
    self.onPressed = onPressed
  }
  
  var body: some View {
    Button (action: {
      onPressed?()
    }){
      EmptyView()
    }
    .buttonStyle(
      HDSListItemStyle(
        label: label,
        subLabel: subLabel,
        image: image,
        height: height,
        toggle: toggle
      )
    )
  }
}

fileprivate struct HDSListItemStyle: ButtonStyle {
  
  let label: String?
  let subLabel: String?
  let image: UIImage?
  let height: CGFloat?
  let toggle: HDSToggle?
  
  func makeBody(configuration: Configuration) -> some View {
    let pressed = configuration.isPressed
    HStack(spacing: 12){
      if image != nil {
        Image(uiImage: image!)
          .resizable()
          .scaledToFit()
          .frame(width: 48, height: 48)
      }
      
      VStack(alignment: .leading, spacing: 0) {
        Text(label ?? "")
          .customFont(Fonts.body1.copyWith(
            color: Palette.black01Basic
          ))
        Text(subLabel ?? "")
          .customFont(Fonts.detail3.copyWith(
            color: Palette.gray800
          ))
      }
      Spacer()
      if toggle == nil {
        Image(Assets.nextButton)
          .resizable()
          .scaledToFit()
          .frame(width: 24, height: 24)
      } else {
        toggle?.onTapGesture {
          self.toggle?.isOn.toggle()
        }
      }
    }
    .frame(height: height)
    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 12))
    .background(pressed ? Palette.gray100 : Palette.white01Basic)
  }
}

struct Previews_HDSListItemView_Previews: PreviewProvider {
  @State static var isOn: Bool = false
  
  static var previews: some View {
    VStack {
      HDSListItemView(label: "Text Enabled", subLabel: "Subtext")
      HDSListItemView(label: "Text Enabled", subLabel: "Subtext", toggle: HDSToggle(type: .basic, isOn: $isOn))
      HDSListItemView(label: "Text Enabled", subLabel: "Subtext", image: UIImage(systemName: "person.fill"))
    }
  }
}


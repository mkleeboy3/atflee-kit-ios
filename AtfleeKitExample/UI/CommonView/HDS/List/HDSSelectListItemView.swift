//
//  HDSSelectListItemView.swift
//  AtfleeKitExample
//
//  Created by wy.jeon on 2023/02/10.
//

import SwiftUI

enum HDSSelectListItemType {
  case basic
  case detail
}

struct HDSSelectListItemView: View {
  
  @Binding var selected: Bool
  
  let type: HDSSelectListItemType
  let label: String?
  let height: CGFloat?
  let onPressed: VoidCallback?
  
  init(
    type: HDSSelectListItemType,
    selected: Binding<Bool>,
    label: String? = nil,
    height: CGFloat? = 70,
    onPressed: VoidCallback? = nil
  ) {
    self.type = type
    self._selected = selected
    self.label = label
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
      HDSSelectListItemStyle(
        type: type,
        selected: $selected,
        label: label,
        height: height
      )
    )
  }
}

fileprivate struct HDSSelectListItemStyle: ButtonStyle {
  private let virticalPadding: CGFloat = 4
  private let horizontalPadding: CGFloat = 8
  
  let type: HDSSelectListItemType
  @Binding var selected: Bool
  let label: String?
  let height: CGFloat?
  
  func makeBody(configuration: Configuration) -> some View {
    let pressed = configuration.isPressed
    ZStack {
      GeometryReader { geoReader in
        
        if type == .basic, selected {
          HStack {
          }
          .frame(width: geoReader.size.width - horizontalPadding * 2, height: geoReader.size.height - virticalPadding * 2)
          .background(Palette.gray100)
          .cornerRadius(12)
          .offset(x: horizontalPadding, y: virticalPadding)
        }
        
        HStack(spacing: 12){
          selectTypeView(type: type)
          
          Spacer()
          
          Image(Assets.nextButton)
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
        }
        .frame(height: height)
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 12))
        .background(pressed ? Palette.gray100 : Palette.transparent)
        .cornerRadius(selected ? 12 : 0)
      }
    }
    .frame(height: height)
    .background(Palette.white01Basic)
  }
  
  @ViewBuilder
  func selectTypeView(type: HDSSelectListItemType) -> some View {
    switch type {
    case .basic:
      Image(selected ? Assets.checkRoundEnabled : Assets.checkRoundDisabled)
        .resizable()
        .scaledToFit()
        .frame(width: 24, height: 24)
        .onTapGesture {
          selected.toggle()
        }
      
      Text(label ?? "")
        .customFont(Fonts.body1.copyWith(
          color: Palette.black01Basic
        ))
      
    case .detail:
      Image(selected ? Assets.checkMarkEnabled : Assets.checkMarkDisabled)
        .resizable()
        .scaledToFit()
        .frame(width: 24, height: 24)
        .onTapGesture {
          selected.toggle()
        }
      
      Text(label ?? "")
        .customFont(Fonts.detail4.copyWith(
          color: Palette.gray800
        ))
    }
  }
}

struct Previews_HDSSelectListItemView_Previews: PreviewProvider {
  @State static var isSelectedFalse: Bool = false
  @State static var isSelectedTrue: Bool = true
  
  static var previews: some View {
    VStack {
      HDSSelectListItemView(type: .basic, selected: $isSelectedFalse, label: "Something Text Enabled")
      HDSSelectListItemView(type: .basic, selected: $isSelectedTrue, label: "Something Text Enabled")
      HDSSelectListItemView(type: .detail, selected: $isSelectedFalse, label: "Something Text Enabled")
      HDSSelectListItemView(type: .detail, selected: $isSelectedTrue, label: "Something Text Enabled")
    }
  }
}


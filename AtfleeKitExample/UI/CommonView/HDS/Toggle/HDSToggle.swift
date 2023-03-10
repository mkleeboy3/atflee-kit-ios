//
//  HDSToggle.swift
//  AtfleeKitExample
//
//  Created by wy.jeon on 2023/02/10.
//

import SwiftUI

enum HDSToggleType {
  case basic
  case old
}

struct HDSToggle: View {
  @Binding var isOn: Bool
  
  let type: HDSToggleType?
  let disabled: Bool?
  let width: CGFloat?
  let height: CGFloat?
  let diameter: CGFloat?
  let knobOnColor: Color?
  let knobOffColor: Color?
  let knobDisabledColor: Color?
  let trackOnColor: Color?
  let trackOffColor: Color?
  let trackDisabledColor: Color?
  
  init(
    type: HDSToggleType? = .basic,
    disabled: Bool? = false,
    isOn: Binding<Bool>,
    width: CGFloat? = nil,
    height: CGFloat? = nil,
    diameter: CGFloat? = nil,
    knobOnColor: Color? = nil,
    knobOffColor: Color? = nil,
    knobDisabledColor: Color? = nil,
    trackOnColor: Color? = nil,
    trackOffColor: Color? = nil,
    trackDisabledColor: Color? = nil
  ) {
    self.type = type
    self.disabled = disabled
    self._isOn = isOn
    self.width = width
    self.height = height
    self.diameter = diameter
    self.knobOnColor = knobOnColor
    self.knobOffColor = knobOffColor
    self.knobDisabledColor = knobDisabledColor
    self.trackOnColor = trackOnColor
    self.trackOffColor = trackOffColor
    self.trackDisabledColor = trackDisabledColor
  }
  
  var body: some View {
    view(type: type)
  }
  
  @ViewBuilder
  func view(type: HDSToggleType?) -> some View {
    switch type {
    case .basic:
      Toggle("", isOn: $isOn)
        .toggleStyle(
          BasicToggleStyle(
            disabled: disabled,
            width: width,
            height: height,
            diameter: diameter,
            knobOnColor: knobOnColor,
            knobOffColor: knobOffColor,
            knobDisabledColor: knobDisabledColor,
            trackOnColor: trackOnColor,
            trackOffColor: trackOffColor,
            trackDisabledColor: trackDisabledColor
          )
        )
    case .old:
      Toggle("", isOn: $isOn)
        .toggleStyle(
          OldToggleStyle(
            disabled: disabled,
            width: width,
            height: height,
            diameter: diameter,
            knobOnColor: knobOnColor,
            knobOffColor: knobOffColor,
            knobDisabledColor: knobDisabledColor,
            trackOnColor: trackOnColor,
            trackOffColor: trackOffColor,
            trackDisabledColor: trackDisabledColor
          )
        )
      
    default:
      Toggle("", isOn: $isOn)
        .toggleStyle(
          BasicToggleStyle(
            disabled: disabled,
            width: width,
            height: height,
            diameter: diameter,
            knobOnColor: knobOnColor,
            knobOffColor: knobOffColor,
            knobDisabledColor: knobDisabledColor,
            trackOnColor: trackOnColor,
            trackOffColor: trackOffColor,
            trackDisabledColor: trackDisabledColor
          )
        )
    }
  }
}

fileprivate struct BasicToggleStyle: ToggleStyle {
  let disabled: Bool?
  let width: CGFloat?
  let height: CGFloat?
  let diameter: CGFloat?
  let knobOnColor: Color?
  let knobOffColor: Color?
  let knobDisabledColor: Color?
  let trackOnColor: Color?
  let trackOffColor: Color?
  let trackDisabledColor: Color?
  
  func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: 0) {
      ZStack(alignment: configuration.isOn ? .trailing : .leading) {
        RoundedRectangle(cornerRadius: height ?? 32)
          .frame(width: width ?? 52, height: height ?? 32)
          .foregroundColor(disabled == true ? Palette.gray300 : configuration.isOn ? Palette.primary500 : Palette.gray600)
        
        RoundedRectangle(cornerRadius: diameter ?? 24)
          .frame(width: diameter ?? 24, height: diameter ?? 24)
          .padding(4)
          .foregroundColor(.white)
          .onTapGesture {
            if disabled == false {
              withAnimation {
                configuration.isOn.toggle()
              }
            }
          }
      }
    }
  }
}

fileprivate struct OldToggleStyle: ToggleStyle {
  let disabled: Bool?
  let width: CGFloat?
  let height: CGFloat?
  let diameter: CGFloat?
  let knobOnColor: Color?
  let knobOffColor: Color?
  let knobDisabledColor: Color?
  let trackOnColor: Color?
  let trackOffColor: Color?
  let trackDisabledColor: Color?
  
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.label
      ZStack(alignment: configuration.isOn ? .trailing : .leading) {
        
        RoundedRectangle(cornerRadius: height ?? 14)
          .frame(width: width ?? 34, height: height ?? 14)
          .foregroundColor(disabled == true ? Palette.gray300 : configuration.isOn ? Palette.primary300 : Palette.gray600)
          .padding(2)
        
        RoundedRectangle(cornerRadius: diameter ?? 20)
          .frame(width: diameter ?? 20, height: diameter ?? 20)
          .foregroundColor(disabled == true ? Palette.gray300 : configuration.isOn ? Palette.primary500 : Palette.white01Basic)
          .shadow(
            color: configuration.isOn ? Palette.shadowBlack06Percent : Palette.shadowBlack20Percent,
            radius: configuration.isOn ? 1 : 2, x: 0, y: configuration.isOn ? 3 : 1)
          .shadow(
            color: configuration.isOn ? Palette.shadowBlack20Percent: Palette.shadowBlack10Percent,
            radius: configuration.isOn ? 8 : 0.3, x: 0, y: configuration.isOn ? 3 : 0.1)
          .onTapGesture {
            if disabled == false {
              withAnimation {
                configuration.isOn.toggle()
              }
            }
          }
      }
    }
  }
}

struct Previews_HDSToggle_Previews: PreviewProvider {
  @State static var isOn: Bool = true
  @State static var isOff: Bool = false
  
  static var previews: some View {
    VStack {
      HStack {
        Text("Basic")
        HDSToggle(type: .basic, isOn: $isOn)
        HDSToggle(type: .basic, disabled: true, isOn: $isOff)
      }
      
      HStack {
        Text("Old")
        HDSToggle(type: .old, isOn: $isOn)
        HDSToggle(type: .old, disabled: true, isOn: $isOff)
      }
    }
  }
}

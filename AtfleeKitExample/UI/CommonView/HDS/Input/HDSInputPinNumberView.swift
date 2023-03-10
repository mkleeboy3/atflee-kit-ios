//
//  HDSInputPinNumberView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/29.
//

import SwiftUI

struct HDSInputPinNumberView: View {
  @Binding var text: String
  @Binding var error: Bool
  
  @Binding var focused: Bool
  
  let hasCursorBlinkAnimation: Bool
  let legend: String
  let maxLength: Int
  let backgroundColor: Color
  
  init(
    text: Binding<String>,
    error: Binding<Bool>,
    focused: Binding<Bool>,
    hasCursorBlinkAnimation: Bool = false,
    legend: String,
    maxLength: Int,
    backgroundColor: Color = Palette.gray100
  ) {
    self._text = text
    self._error = error
    self._focused = focused
    self.hasCursorBlinkAnimation = hasCursorBlinkAnimation
    self.legend = legend
    self.maxLength = maxLength
    self.backgroundColor = backgroundColor
  }
  
  var body: some View {
    ZStack {
      textInputView
      
      HStack(spacing: 8) {
        ForEach(0 ..< maxLength, id: \.self) { index in
          let state = getCellState(index: index)
          
          HDSInputPinNumberCellView(
            hasCursorBlinkAnimation: hasCursorBlinkAnimation,
            focused: focused,
            error: error,
            state: state,
            legend: legend,
            backgroundColor: Palette.gray100
          )
        }
      }
      .padding(.horizontal, 28)
      .onTapGesture {
        focused = true
      }
      .animation(AppTheme.defaultAnimation, value: text)
      .onChange(of: text) { _ in
        error = false
      }
    }
  }
}

extension HDSInputPinNumberView {
  var textInputView: some View {
    InvisibleTextFieldView(
      text: $text,
      focused: $focused,
      font: Fonts.title4,
      textFormatter: PinNumberFormatter(maxLength: maxLength),
      keyboardType: .numberPad
    )
    .allowsHitTesting(false)
  }
}

extension HDSInputPinNumberView {
  private func getCellState(index: Int) -> HDSInputPinNumberCellView.CellState {
    if text.isEmpty {
      if index == 0 { return .focus }
      
      return .empty
    }
    
    let lastIndex = (text.count - 1 < 0) ? 0 : text.count - 1
    if index <= lastIndex { return .entered }
    
    if index == lastIndex + 1 { return .focus }
    
    return .empty
  }
}

extension HDSInputPinNumberView {
  struct PinNumberFormatter: TextFieldFormatterProtocol {
    let maxLength: Int
    
    init(maxLength: Int) {
      self.maxLength = maxLength
    }
    
    func format(_ newValue: String) -> String {
      guard !newValue.isEmpty else { return newValue }
      
      let regex = try! NSRegularExpression(
        pattern: #"(^[\d]*$)"#
      )
      
      guard regex.hasMatch(in: newValue) else { return getOldValue(from: newValue) }
      
      guard newValue.count <= maxLength else { return getOldValue(from: newValue) }
      
      return newValue
    }
  }
}

//
//  HDSInputBoxView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/29.
//

import SwiftUI

struct HDSInputBoxView: View {
  @Binding var text: String
  @Binding var error: Bool
  
  @State var focused: Bool = false
  
  let label: String?
  let placeholderLabel: String?
  let backgroundColor: Color
  let textFormatter: TextFieldFormatterProtocol?
  
  init(
    text: Binding<String>,
    error: Binding<Bool>,
    label: String? = nil,
    placeholderLabel: String? = nil,
    backgroundColor: Color = Palette.white100Percent,
    textFormatter: TextFieldFormatterProtocol? = nil
  ) {
    self._text = text
    self._error = error
    self.label = label
    self.placeholderLabel = placeholderLabel
    self.backgroundColor = backgroundColor
    self.textFormatter = textFormatter
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HDSInputLabelView(
        label: label,
        focused: focused,
        error: error
      )
      
      Spacer().frame(height: 4)
      
      TextFieldView(
        text: $text,
        focused: $focused,
        error: error,
        font: Fonts.body1,
        placeholderLabel: placeholderLabel,
        placeholderFont: Fonts.body1.copyWith(
          color: Palette.gray500
        ),
        textFormatter: textFormatter
      )
      .frame(maxWidth: .infinity)
    }
    .padding(24)
    .background(backgroundColor)
  }
}

//
//  HDSInputLineOptionalView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/29.
//

import SwiftUI

struct HDSInputLineOptionalView<Content: View>: View {
  @Binding var text: String
  @Binding var error: Bool
  
  @State var focused: Bool = false
  
  let hasShakeAnimationOnError: Bool
  let label: String?
  let placeholderLabel: String?
  let captionLabel: String?
  let errorCaptionLabel: String?
  let textFormatter: TextFieldFormatterProtocol?
  let unitContent: Content
  
  init(
    text: Binding<String>,
    error: Binding<Bool>,
    hasShakeAnimationOnError: Bool = false,
    label: String? = nil,
    placeholderLabel: String? = nil,
    captionLabel: String? = nil,
    errorCaptionLabel: String? = nil,
    textFormatter: TextFieldFormatterProtocol? = nil,
    @ViewBuilder unitContent: @escaping () -> Content
  ) {
    self._text = text
    self._error = error
    self.hasShakeAnimationOnError = hasShakeAnimationOnError
    self.label = label
    self.placeholderLabel = placeholderLabel
    self.captionLabel = captionLabel
    self.errorCaptionLabel = errorCaptionLabel
    self.textFormatter = textFormatter
    self.unitContent = unitContent()
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      textFieldView
      
      Spacer().frame(height: 4)
      
      HDSInputUnderlineView(
        focused: focused,
        error: error
      )
      
      HDSInputCaptionView(
        hasShakeAnimation: hasShakeAnimationOnError,
        focused: focused,
        error: error,
        captionLabel: captionLabel,
        errorCaptionLabel: errorCaptionLabel
      )
    }
  }
}

extension HDSInputLineOptionalView {
  var textFieldView: some View {
    HStack(spacing: 0) {
      HDSInputLabelView(
        label: label,
        focused: focused,
        error: error
      )
      
      TextFieldView(
        text: $text,
        focused: $focused,
        error: error,
        font: Fonts.emphasis3,
        placeholderLabel: placeholderLabel,
        placeholderFont: Fonts.emphasis3.copyWith(
          color: Palette.gray500
        ),
        textAlignment: .right,
        textFormatter: textFormatter
      )
      .onChange(of: text) { newValue in
        error = false
      }
      .padding(.horizontal, 8)
      .frame(maxWidth: .infinity)
      
      unitContent
    }
  }
}

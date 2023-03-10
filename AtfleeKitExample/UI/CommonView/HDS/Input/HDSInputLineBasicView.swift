//
//  HDSInputLineBasicView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/26.
//

import SwiftUI

struct HDSInputLineBasicView<Content: View>: View {
  @Binding var text: String
  @Binding var error: Bool
  
  @State var focused: Bool = false
  
  let hasShakeAnimationOnError: Bool
  let inputHidden: Bool
  let label: String?
  let placeholderLabel: String?
  let captionLabel: String?
  let errorCaptionLabel: String?
  let textFormatter: TextFieldFormatterProtocol?
  let suffixContent: Content
  
  init(
    text: Binding<String>,
    error: Binding<Bool>,
    hasShakeAnimationOnError: Bool = false,
    inputHidden: Bool = false,
    label: String? = nil,
    placeholderLabel: String? = nil,
    captionLabel: String? = nil,
    errorCaptionLabel: String? = nil,
    textFormatter: TextFieldFormatterProtocol? = nil,
    @ViewBuilder suffixContent: @escaping () -> Content
  ) {
    self._text = text
    self._error = error
    self.hasShakeAnimationOnError = hasShakeAnimationOnError
    self.inputHidden = inputHidden
    self.label = label
    self.placeholderLabel = placeholderLabel
    self.captionLabel = captionLabel
    self.errorCaptionLabel = errorCaptionLabel
    self.textFormatter = textFormatter
    self.suffixContent = suffixContent()
  }
  
  var body: some View {
    ZStack(alignment: .trailing) {
      VStack(alignment: .leading, spacing: 0) {
        labelView
        
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
      
      suffixContent
    }
  }
}

extension HDSInputLineBasicView {
  var labelView: some View {
    let visible = !text.isEmpty
    
    return Text(label ?? "")
      .customFont(
        Fonts.detail4.copyWith(
          color: visible
          ? error
          ? Palette.feedbackRed500
          : Palette.primary500
          : Palette.transparent
        )
      )
      .frame(height: 24)
      .animation(AppTheme.defaultAnimation, value: visible)
      .animation(AppTheme.defaultAnimation, value: error)
  }
  
  var textFieldView: some View {
    TextFieldView(
      text: $text,
      focused: $focused,
      error: error,
      font: Fonts.body2,
      placeholderLabel: placeholderLabel,
      placeholderFont: Fonts.body2.copyWith(color: Palette.gray500),
      inputHidden: inputHidden,
      textFormatter: textFormatter
    )
    .onChange(of: text) { newValue in
      error = false
    }
    .padding(.trailing, 8)
    .frame(maxWidth: .infinity)
    .frame(height: 30)
  }
}

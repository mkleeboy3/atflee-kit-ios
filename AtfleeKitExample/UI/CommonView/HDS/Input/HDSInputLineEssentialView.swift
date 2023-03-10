//
//  HDSInputLineEssentialView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/27.
//

import SwiftUI

struct HDSInputLineEssentialView: View {
  @Binding var text: String
  @Binding var error: Bool
  
  @State var focused: Bool = false
  
  let hasShakeAnimationOnError: Bool
  let label: String?
  let placeholderLabel: String?
  let unitLabel: String?
  let captionLabel: String?
  let errorCaptionLabel: String?
  let textFormatter: TextFieldFormatterProtocol?
  
  init(
    text: Binding<String>,
    error: Binding<Bool>,
    hasShakeAnimationOnError: Bool = false,
    label: String? = nil,
    placeholderLabel: String? = nil,
    unitLabel: String? = nil,
    captionLabel: String? = nil,
    errorCaptionLabel: String? = nil,
    textFormatter: TextFieldFormatterProtocol? = nil
  ) {
    self._text = text
    self._error = error
    self.hasShakeAnimationOnError = hasShakeAnimationOnError
    self.label = label
    self.placeholderLabel = placeholderLabel
    self.unitLabel = unitLabel
    self.captionLabel = captionLabel
    self.errorCaptionLabel = errorCaptionLabel
    self.textFormatter = textFormatter
  }
  
  var body: some View {
    HDSInputLineOptionalView(
      text: $text,
      error: $error,
      hasShakeAnimationOnError: hasShakeAnimationOnError,
      label: label,
      placeholderLabel: placeholderLabel,
      captionLabel: captionLabel,
      errorCaptionLabel: errorCaptionLabel,
      textFormatter: textFormatter
    ) {
      Text(unitLabel ?? "")
        .customFont(Fonts.detail4.copyWith(
          color: Palette.gray800
        ))
    }
  }
}

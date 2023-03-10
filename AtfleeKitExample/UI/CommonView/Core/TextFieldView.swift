//
//  TextFieldView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/26.
//

import SwiftUI
import UIKit

var testIndex = 0

struct TextFieldView: UIViewRepresentable {
  @Binding var text: String
  @Binding var focused: Bool
  
  let error: Bool
  let font: CustomFont
  let placeholderFont: CustomFont
  let placeholderLabel: String?
  let inputHidden: Bool
  let textAlignment: TextAlignment
  let textFormatter: TextFieldFormatterProtocol?
  let positiveColor: Color
  let negativeColor: Color
  
  init(
    text: Binding<String>,
    focused: Binding<Bool>,
    error: Bool,
    font: CustomFont,
    placeholderLabel: String? = nil,
    placeholderFont: CustomFont,
    inputHidden: Bool = false,
    textAlignment: TextAlignment = .left,
    textFormatter: TextFieldFormatterProtocol? = nil,
    positiveColor: Color = Palette.primary500,
    negativeColor: Color = Palette.feedbackRed500
  ) {
    self._text = text
    self._focused = focused
    self.error = error
    self.font = font
    self.placeholderLabel = placeholderLabel
    self.placeholderFont = placeholderFont
    self.inputHidden = inputHidden
    self.textAlignment = textAlignment
    self.textFormatter = textFormatter
    self.positiveColor = positiveColor
    self.negativeColor = negativeColor
  }
  
  func makeUIView(context: UIViewRepresentableContext<TextFieldView>) -> UITextField {
    let textField = UITextField()
    textField.isUserInteractionEnabled = true
    textField.isSecureTextEntry = inputHidden
    textField.font = UIFont(
      name: font.name,
      size: font.size
    )
    textField.textColor = font.color.toUIColor()
    textField.tintColor = positiveColor.toUIColor()
    textField.attributedPlaceholder = NSAttributedString(
      string: placeholderLabel ?? "",
      attributes: [
        NSAttributedString.Key.font: placeholderFont.toUIFont(),
        NSAttributedString.Key.foregroundColor: placeholderFont.color.toUIColor()
      ]
    )
    textField.textAlignment = textAlignment.toNSTextAlignment()
    textField.autocorrectionType = UITextAutocorrectionType.no
    textField.autocapitalizationType = UITextAutocapitalizationType.none
    textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    textField.delegate = context.coordinator
    return textField
  }

  func updateUIView(
    _ uiView: UITextField,
    context: Context
  ) {
    uiView.tintColor = error ? negativeColor.toUIColor() : positiveColor.toUIColor()
    DispatchQueue.main.async {
      uiView.layer.layoutIfNeeded()
      uiView.layer.setNeedsLayout()
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(
      text: $text,
      focused: $focused,
      textFormatter: textFormatter
    )
  }
  
  class Coordinator: NSObject, UITextFieldDelegate {
    @Binding var text: String
    @Binding var focused: Bool
    
    let textFormatter: TextFieldFormatterProtocol?
    
    init(
      text: Binding<String>,
      focused: Binding<Bool>,
      textFormatter: TextFieldFormatterProtocol? = nil
    ) {
      self._text = text
      self._focused = focused
      self.textFormatter = textFormatter
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
      let text = textField.text ?? ""
      self.text = text
    }
    
    func textField(
      _ textField: UITextField,
      shouldChangeCharactersIn range: NSRange,
      replacementString string: String
    ) -> Bool {
      var shouldChange = true
      let fullText = (textField.text ?? "") + string
      if let textFormatter = textFormatter {
        let formattedText = textFormatter.format(fullText)
        if fullText != formattedText {
          shouldChange = false
        }
      }
      
      return shouldChange
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      DispatchQueue.main.async {
        self.focused = true
      }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      DispatchQueue.main.async {
        self.focused = false
      }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return false
    }
  }
  
  enum TextAlignment {
    case left
    case center
    case right
    
    func toNSTextAlignment() -> NSTextAlignment {
      switch (self) {
        case .left:
          return NSTextAlignment.left
          
        case .center:
          return NSTextAlignment.center
          
        case .right:
          return NSTextAlignment.right
      }
    }
  }
}

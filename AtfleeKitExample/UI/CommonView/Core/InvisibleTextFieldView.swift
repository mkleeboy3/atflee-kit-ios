//
//  InvisibleTextFieldView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/29.
//

import Foundation
import SwiftUI
import UIKit

struct InvisibleTextFieldView: UIViewRepresentable {
  @Binding var text: String
  @Binding var focused: Bool
  
  let font: CustomFont
  let textAlignment: TextAlignment
  let textFormatter: TextFieldFormatterProtocol?
  let keyboardType: UIKeyboardType
  
  init(
    text: Binding<String>,
    focused: Binding<Bool>,
    font: CustomFont,
    textAlignment: TextAlignment = .left,
    textFormatter: TextFieldFormatterProtocol? = nil,
    keyboardType: UIKeyboardType = .default
  ) {
    self._text = text
    self._focused = focused
    self.font = font
    self.textAlignment = textAlignment
    self.textFormatter = textFormatter
    self.keyboardType = keyboardType
  }
  
  func makeUIView(
    context: UIViewRepresentableContext<InvisibleTextFieldView>
  ) -> _NonDefaultInteractionDisabledTextField {
    let textField = _NonDefaultInteractionDisabledTextField(frame: .zero)
    textField.font = UIFont(name: font.name, size: font.size)
    textField.textColor = Palette.transparent.toUIColor()
    textField.tintColor = Palette.transparent.toUIColor()
    textField.textAlignment = textAlignment.toNSTextAlignment()
    textField.autocorrectionType = UITextAutocorrectionType.no
    textField.autocapitalizationType = UITextAutocapitalizationType.none
    textField.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
    textField.keyboardType = keyboardType
    textField.delegate = context.coordinator
    return textField
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(
      text: $text,
      focused: $focused,
      textFormatter: textFormatter
    )
  }
  
  func updateUIView(
    _ uiView: _NonDefaultInteractionDisabledTextField,
    context: Context
  ) {
    uiView.text = text
    uiView.tintColor = Palette.transparent.toUIColor()
    
    if focused {
      DispatchQueue.main.async {
        uiView.becomeFirstResponder()
      }
    } else {
      DispatchQueue.main.async {
        uiView.resignFirstResponder()
      }
    }
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

class _NonDefaultInteractionDisabledTextField: UITextField {
  // To disable non-default interaction (e.g., copy, paste, drag, select, live-text)
  override func canPerformAction(
    _ action: Selector,
    withSender sender: Any?
  ) -> Bool {
    return false
  }
  
  // To set cursor invisible
  override func caretRect(for position: UITextPosition) -> CGRect {
    return CGRectZero
  }
  
  // To disable long press
  override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    guard !gestureRecognizer.isKind(of: UILongPressGestureRecognizer.self) else { return false }
    
    return true
  }
}

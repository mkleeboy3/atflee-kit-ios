//
//  TextFieldFormatterProtocol.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/18.
//

import Foundation

protocol TextFieldFormatterProtocol {
  func format(_ newValue: String) -> String
}

extension TextFieldFormatterProtocol {
  func getOldValue(from newValue: String) -> String {
    let endIndex = String.Index(
      utf16Offset: newValue.count - 1,
      in: newValue
    )
    return String(newValue[..<endIndex])
  }
}

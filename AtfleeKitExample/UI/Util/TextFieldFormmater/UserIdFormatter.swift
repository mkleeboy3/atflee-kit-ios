//
//  TextFieldFormatter.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/18.
//

import Foundation

struct UserIdFormatter: TextFieldFormatterProtocol {
  private let maxLength = 10
  
  func format(_ newValue: String) -> String {
    guard !newValue.isEmpty else { return newValue }
    
    let regex = try! NSRegularExpression(
      pattern: #"(^[!@#$%^*&~()\-_=+|\[\]{};:`,.<>/?a-zA-Z\d]*$)"#
    )

    guard regex.hasMatch(in: newValue) else { return getOldValue(from: newValue) }

    guard newValue.count <= maxLength else { return getOldValue(from: newValue) }
    
    return newValue
  }
}

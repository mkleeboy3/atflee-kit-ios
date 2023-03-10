//
//  Regex+Extension.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/18.
//

import Foundation

extension NSRegularExpression {
  func hasMatch(in s: String) -> Bool {
    let range = NSRange(s.startIndex..., in: s)
    let matches = self.matches(in: s, range: range)
    return !matches.isEmpty
  }
}

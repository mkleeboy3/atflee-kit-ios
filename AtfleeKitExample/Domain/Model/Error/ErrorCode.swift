//
//  ErrorCode.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/18.
//

import Foundation

enum ErrorCode: String, CaseIterable {
  case unknown
  case networkError
  case duplicateLogin = "ERR-401-004"
  case versionUpdate = "ERR-406-000"
  case tokenExpired = "ERR-401-001"
  case refreshTokenDoesNotExist = "ERR-401-006"
  case wrongTokenFormat = "ERR-401-002"
  case sessionExpired = "ERR-401-007"
  case invalidIdPassword = "ERR-400-001"
  case invalidFormat = "ERR-400-000"
  case invalidPhoneNumberFormat = "ERR-400-013"
  case adminDeletedAccount = "ERR-400-002"
  case userDeletedAccount = "ERR-400-003"
  case adminInvalidatedAccount = "ERR-400-014"
  case userIdNotFoundUnderPhoneNumber = "ERR-404-001"
  case userIdNotFound = "ERR-404-002"
  case phoneNumberDoesNotMatchUserId = "ERR-400-012"
  case certCodeIncorrect = "ERR-400-008"
  case certCodeTooManyRequests = "ERR-429-000"
  case alreadySignedOut
  case tempTokenExpired = "ERR-401-008"
  case signInAdminDeletedAccount = "ERR-400-010"
  case signInUserDeletedAccount = "ERR-400-011"
  case signInAdminInvalidatedAccount = "ERR-400-015"
  
  static func fromRawValue(_ rawValue: String) -> ErrorCode {
    guard let match = ErrorCode.allCases.first(where: { $0.rawValue == rawValue }) else {
      return ErrorCode.unknown
    }
    
    return match
  }
  
  func isCommonError() -> Bool {
    switch (self) {
      case .duplicateLogin,
          .sessionExpired,
          .refreshTokenDoesNotExist,
          .versionUpdate,
          .adminDeletedAccount,
          .userDeletedAccount,
          .adminInvalidatedAccount:
        return true
        
      default:
        return false
    }
  }
}

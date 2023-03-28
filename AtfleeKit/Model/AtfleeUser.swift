//
//  AtfleeUser.swift
//  AtfleeKit
//
//  Created by Ming on 2023/03/06.
//

import Foundation
import AtfleeBaseKit

public struct AtfleeUser {
  public let age: UInt
  public let height: UInt
  public let weight: Double
  public let gender: AtfleeUserGenderType
  public let deviceType: AtfleeDeviceType
  
  func toICUserInfo() -> ICUserInfo {
    var user = ICUserInfo()
    user.age = age
    user.height = height
    user.weight = Float(weight)
    user.sex = gender.toICSexType()
    user.bfaType = deviceType.toICBFAType()
    
    return user
  }
  
  public static var `default`: AtfleeUser {
    AtfleeUser(
      age: 25,
      height: 175,
      weight: 65,
      gender: .male,
      deviceType: .t9
    )
  }
}

public enum AtfleeUserGenderType {
  case male
  case female
  
  internal func toICSexType() -> ICSexType {
    switch self {
      case .male:
        return .male
      case .female:
        return .femal
    }
  }
}

public enum AtfleeDeviceType {
  case t8
  case t9
  case iGrip
  
  public func toICBFAType() -> ICBFAType {
    switch self {
      case .t8:
        return ICBFATypeT8
      case .t9:
        return ICBFATypeT9
      case .iGrip:
        return ICBFATypeIGripV2
    }
  }
}

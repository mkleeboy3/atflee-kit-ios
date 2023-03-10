//
//  Fonts.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/12.
//

import Foundation
import SwiftUI

struct Fonts {
  static let sCoreDreamW100 = "S-CoreDream-1Thin"
  static let sCoreDreamW200 = "S-CoreDream-2ExtraLight"
  static let sCoreDreamW300 = "S-CoreDream-3Light"
  static let sCoreDreamW400 = "S-CoreDream-4Regular"
  static let sCoreDreamW500 = "S-CoreDream-5Medium"
  static let sCoreDreamW600 = "S-CoreDream-6Bold"
  static let sCoreDreamW700 = "S-CoreDream-7ExtraBold"
  static let sCoreDreamW800 = "S-CoreDream-8Heavy"
  static let sCoreDreamW900 = "S-CoreDream-9Black"
  
  static let dungGeunMo = "DungGeunMo"
  
  // - MARK: HDS Fonts
  private static let pretendardBlack = "Pretendard-Black"
  private static let pretendardBold = "Pretendard-Bold"
  private static let pretendardExtraBold = "Pretendard-ExtraBold"
  private static let pretendardExtraLight = "Pretendard-ExtraLight"
  private static let pretendardLight = "Pretendard-Light"
  private static let pretendardMedium = "Pretendard-Medium"
  private static let pretendardRegular = "Pretendard-Regular"
  private static let pretendardSemiBold = "Pretendard-SemiBold"
  private static let pretendardThin = "Pretendard-Thin"
  
  static let detail1 = CustomFont(
    name: pretendardMedium,
    size: 10,
    lineHeightProportion: 1.5
  )
  static let detail2 = CustomFont(
    name: pretendardMedium,
    size: 12,
    lineHeightProportion: 1.5
  )
  static let detail3 = CustomFont(
    name: pretendardMedium,
    size: 14,
    lineHeightProportion: 1.5
  )
  static let detail4 = CustomFont(
    name: pretendardMedium,
    size: 16,
    lineHeightProportion: 1.5
  )
  
  static let body1 = CustomFont(
    name: pretendardSemiBold,
    size: 18,
    lineHeightProportion: 1.5
  )
  static let body2 = CustomFont(
    name: pretendardSemiBold,
    size: 20,
    lineHeightProportion: 1.5
  )
  static let body3 = CustomFont(
    name: pretendardSemiBold,
    size: 22,
    lineHeightProportion: 1.5
  )
  
  static let title1 = CustomFont(
    name: pretendardBold,
    size: 24,
    lineHeightProportion: 1.3
  )
  static let title2 = CustomFont(
    name: pretendardBold,
    size: 26,
    lineHeightProportion: 1.3
  )
  static let title3 = CustomFont(
    name: pretendardBold,
    size: 28,
    lineHeightProportion: 1.3
  )
  static let title4 = CustomFont(
    name: pretendardBold,
    size: 30,
    lineHeightProportion: 1.3
  )
  
  static let emphasis1 = CustomFont(
    name: pretendardBold,
    size: 30,
    lineHeightProportion: 1.3
  )
  static let emphasis2 = CustomFont(
    name: pretendardBold,
    size: 32,
    lineHeightProportion: 1.3
  )
  static let emphasis3 = CustomFont(
    name: pretendardBold,
    size: 34,
    lineHeightProportion: 1.3
  )
  static let emphasis4 = CustomFont(
    name: pretendardBold,
    size: 36,
    lineHeightProportion: 1.3
  )
}

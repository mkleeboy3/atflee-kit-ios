//
//  AtfleeWeightMeasurement.swift
//  AtfleeKit
//
//  Created by Ming on 2023/03/06.
//

import Foundation
import AtfleeBaseKit

public struct AtfleeWeightMeasurement {
  public let weight: Double
  public let bodyFatPercent: Double
  public let subcutaneousFatPercent: Double
  public let visceralFat: Double
  public let ffm: Double
  public let musclePercent: Double
  public let muscleMass: Double
  public let bmr: Int
  
  internal static func fromICWeightData(_ weightData: ICWeightData) -> AtfleeWeightMeasurement {
    AtfleeWeightMeasurement(
      weight: Double(weightData.weight_kg),
      bodyFatPercent: Double(weightData.bodyFatPercent),
      subcutaneousFatPercent: Double(weightData.subcutaneousFatPercent),
      visceralFat: Double(weightData.visceralFat),
      ffm: Double(weightData.ffm),
      musclePercent: Double(weightData.musclePercent),
      muscleMass: Double(weightData.muscleMass),
      bmr: Int(weightData.bmr)
    )
  }
}

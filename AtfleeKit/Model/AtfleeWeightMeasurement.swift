//
//  AtfleeWeightMeasurement.swift
//  AtfleeKit
//
//  Created by Ming on 2023/03/06.
//

import Foundation
import AtfleeBaseKit

public struct AtfleeWeightMeasurement {
  public let bmi: Double  // (BMI)
  public let bmr: Int // 기초대사량 (kcal)
  public let bodyFatPercent: Double // 체지방률(%)
  public let boneMass: Double // 골질량(kg)
  public let fatFreeMass: Double // 제지방체중(kg)
  public let moistureMass: Double // 체수분(kg)
  public let moisturePercent: Double // 체수분율(%)
  public let muscleMass: Double // 근육(kg)
  public let musclePercent: Double // 근육율 (%)
  public let minerals: Double // 무기질(kg)
  public let physicalAge: Double // 신체나이
  public let proteinPercent: Double // 체단백질율(%)
  public let proteinMass: Double // 체단백질(kg)
  public let skeletalMuscleMass: Double // 골격근량(kg)
  public let skeletalMusclePercent: Double // 골격근율(%)
  public let subcutaneousFatPercent: Double // 피하지방율(%)
  public let visceralFat: Double // 내장지방지수
  public let waistHipRatio: Double // 복부지방율(%)
  public let weightKg: Double // 몸무게(kg)
  public let extraData: AtfleeExtraWeightMeasurement?
  
  static func fromICWeightData(_ weightData: ICWeightData) -> AtfleeWeightMeasurement {
    AtfleeWeightMeasurement(
      bmi: Double(weightData.bmi),
      bmr: Int(weightData.bmr),
      bodyFatPercent: Double(weightData.bodyFatPercent),
      boneMass: Double(weightData.boneMass),
      fatFreeMass: Double(weightData.ffm),
      moistureMass: Double(weightData.moistureMass),
      moisturePercent: Double(weightData.moisturePercent),
      muscleMass: Double(weightData.muscleMass),
      musclePercent: Double(weightData.musclePercent),
      minerals: Double(weightData.minerals),
      physicalAge: Double(weightData.physicalAge),
      proteinPercent: Double(weightData.proteinPercent),
      proteinMass: Double(weightData.proteinMass),
      skeletalMuscleMass: Double(weightData.sm),
      skeletalMusclePercent: Double(weightData.smPercent),
      subcutaneousFatPercent: Double(weightData.subcutaneousFatPercent),
      visceralFat: Double(weightData.visceralFat),
      waistHipRatio: Double(weightData.whr),
      weightKg: Double(weightData.weight_kg),
      extraData: AtfleeExtraWeightMeasurement.fromICWeightExtData(weightData.extData)
    )
  }
}

public struct AtfleeExtraWeightMeasurement {
  public let leftArm: Double // 왼팔 체지방율(%)
  public let rightArm: Double // 오른팔 체지방율(%)
  public let leftLeg: Double // 왼발 체지방율(%)
  public let rightLeg: Double // 오른발 체지방율(%)
  public let allBody: Double // 몸통 체지방율(%)
  public let leftArmKg: Double // 왼팔 체지방
  public let rightArmKg: Double // 오른팔 체지방
  public let leftLegKg: Double // 왼발 체지방
  public let rightLegKg: Double // 오른발 체지방
  public let allBodyKg: Double // 몸통 체지방
  public let leftArmMuscle: Double // 왼팔 골격근
  public let rightArmMuscle: Double // 오른팔 골격근
  public let leftLegMuscle: Double // 왼발 골격근
  public let rightLegMuscle: Double // 오른발 골격근
  public let allBodyMuscle: Double // 몸통 골격근
  public let leftArmMuscleKg: Double // 왼팔 골격근량(kg)
  public let rightArmMuscleKg: Double // 오른팔 골격근량(kg)
  public let leftLegMuscleKg: Double // 왼발 골격근량(kg)
  public let rightLegMuscleKg: Double // 오른발 골격근량(kg)
  public let allBodyMuscleKg: Double // 몸통 골격근량(kg)
  
  static func fromICWeightExtData(_ extData: ICWeightExtData) -> AtfleeExtraWeightMeasurement {
    AtfleeExtraWeightMeasurement(
      leftArm: Double(extData.left_arm),
      rightArm: Double(extData.right_arm),
      leftLeg: Double(extData.left_leg),
      rightLeg: Double(extData.right_leg),
      allBody: Double(extData.all_body),
      leftArmKg: Double(extData.left_arm_kg),
      rightArmKg: Double(extData.right_arm_kg),
      leftLegKg: Double(extData.left_leg_kg),
      rightLegKg: Double(extData.right_leg_kg),
      allBodyKg: Double(extData.all_body_kg),
      leftArmMuscle: Double(extData.left_arm_muscle),
      rightArmMuscle: Double(extData.right_arm_muscle),
      leftLegMuscle: Double(extData.left_leg_muscle),
      rightLegMuscle: Double(extData.right_leg_muscle),
      allBodyMuscle: Double(extData.all_body_muscle),
      leftArmMuscleKg: Double(extData.left_arm_muscle_kg),
      rightArmMuscleKg: Double(extData.right_arm_muscle_kg),
      leftLegMuscleKg: Double(extData.left_leg_muscle_kg),
      rightLegMuscleKg: Double(extData.right_leg_muscle_kg),
      allBodyMuscleKg: Double(extData.all_body_muscle_kg)
    )
  }
}

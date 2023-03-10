//
//  AtfleeDevice.swift
//  AtfleeKit
//
//  Created by Ming on 2023/03/06.
//

import Foundation
import AtfleeBaseKit

public struct AtfleeDevice {
  public let name: String
  public let macAddress: String
  public let rssi: Int
  internal let deviceType: ICDeviceType
  internal let deviceSubtype: ICDeviceSubType
  internal let communicationType: ICDeviceCommunicationType
  internal let services: [String]
  
  internal func toICDevice() -> ICDevice {
    var device = ICDevice()
    device.macAddr = macAddress
    
    return device
  }
  
  internal static func fromICScanDeviceInfo(_ info: ICScanDeviceInfo) -> AtfleeDevice {
    AtfleeDevice(
      name: info.name,
      macAddress: info.macAddr,
      rssi: info.rssi,
      deviceType: info.type,
      deviceSubtype: info.subType,
      communicationType: info.communicationType,
      services: info.services
    )
  }
}

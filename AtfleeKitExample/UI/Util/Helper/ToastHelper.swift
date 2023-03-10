//
//  ToastHelper.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/13.
//

import Foundation
import SwiftUI
import Combine

class ToastHelper: ObservableObject {
  static let shared: ToastHelper = ToastHelper()
  
  private let semaphore = DispatchSemaphore(value: 1)
  private let serialQueue = DispatchQueue(
    label: "net.huary.huskit.toast_serial_queue",
    qos: .userInteractive
  )
  
  private(set) public var isShowingToast: Bool = false
  private(set) public var toastOptions: HDSToastOptions?
  private(set) public var toastString: String?
  
  private init() {}
  
  func showToast(
    toastString: String,
    toastOptions: HDSToastOptions = HDSToastOptions(),
    durationInSeconds: Double = 2.5,
    makeToastsChained: Bool = false
  ) {
    serialQueue.async {
      if (makeToastsChained) {
        self.semaphore.wait()
      } else {
        guard !self.isShowingToast else { return }
      }
      
      self.isShowingToast = true
      self.toastOptions = toastOptions
      self.toastString = toastString
      
      DispatchQueue.main.asyncAfter(deadline: .now() + durationInSeconds) {
        self.hideToast()
      }
      
      DispatchQueue.main.async {
        self.objectWillChange.send()
      }
    }
  }
  
  private func hideToast() {
    isShowingToast = false
    toastOptions = nil
    toastString = nil
    objectWillChange.send()
    
    semaphore.signal()
  }
}

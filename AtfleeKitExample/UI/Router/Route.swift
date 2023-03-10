//
//  Route.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/10.
//

import Foundation
import SwiftUI

typealias RouteCompletionHandler = (ScreenResultProtocol?) -> ()

class Route {
  let path: RoutePath
  let replace: Bool
  let clearStack: Bool
  let arg: ScreenArgProtocol?
  let completionHandler: RouteCompletionHandler?
  
  init(
    path: RoutePath,
    replace: Bool = false,
    clearStack: Bool = false,
    arg: ScreenArgProtocol? = nil,
    completionHandler: RouteCompletionHandler? = nil
  ) {
    self.path = path
    self.replace = replace
    self.clearStack = clearStack
    self.arg = arg
    self.completionHandler = completionHandler
  }
}

extension Route {
  @ViewBuilder
  private func routeOptionConfigured(for view: some View) -> some View {
    view
      .navigationBarHidden(true)
  }
  
  @ViewBuilder
  func buildConfiguredView() -> some View {
    routeOptionConfigured(
      for: self.path.buildScreenView(arg: self.arg)
    )
  }
}

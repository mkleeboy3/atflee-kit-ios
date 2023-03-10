//
//  Router.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/20.
//

import Foundation
import SwiftUI

class Router {
  static let shared = Router()
  
  private let popupHelper = PopupHelper.shared
  
  private(set) public var routes = [Route]()
  
  fileprivate var onPush: ((Route) -> Void)?
  fileprivate var onPop: (() -> Void)?
  fileprivate var onPopToRoot: (() -> Void)?
  
  private init() {
    let initialRoute = Route(path: EnvironmentConstants.initialPath)
    routes.append(initialRoute)
  }
  
  var currentPath: RoutePath {
    routes.last!.path
  }
  
  func push(_ route: Route) {
    if (route.clearStack) {
      routes.removeAll()
    } else if (route.replace) {
      routes.removeLast()
    }
    
    routes.append(route)
    popupHelper.closeDialog()
    onPush?(route)
  }
  
  func pop(result: ScreenResultProtocol? = nil) {
    guard !routes.isEmpty else { return }
    
    routes.last!.completionHandler?(result)
    routes.removeLast()
    popupHelper.closeDialog()
    onPop?()
  }
  
  func popToRoot() {
    guard !routes.isEmpty else { return }
    
    routes.removeAll()
    popupHelper.closeDialog()
    onPopToRoot?()
  }
}

struct RootRouterView<Screen: View>: UIViewControllerRepresentable {
  private let router = Router.shared
  
  @ViewBuilder
  let routeMappingBuilder: (Route) -> Screen
  
  func makeUIViewController(context: Context) -> UINavigationController {
    let navigation = UINavigationController()
    
    let initial = router.routes.first!
    navigation.pushViewController(
      UIHostingController(rootView: initial.buildConfiguredView()),
      animated: true
    )
    
    router.onPush = { routeOption in
      let view = routeMappingBuilder(routeOption)
      navigation.pushViewController(
        UIHostingController(rootView: view),
        animated: true
      )
      
      if (routeOption.clearStack) {
        let lastIndex = navigation.viewControllers.count - 1
        navigation.viewControllers.removeSubrange(0 ..< lastIndex)
      } else if (routeOption.replace) {
        let secondLastIndex = navigation.viewControllers.count - 2
        navigation.viewControllers.remove(at: secondLastIndex)
      }
    }
    
    router.onPop = {
      navigation.popViewController(animated: true)
    }
    
    router.onPopToRoot = {
      navigation.popToRootViewController(animated: true)
    }
    
    return navigation
  }
  
  func updateUIViewController(
    _ uiViewController: UINavigationController,
    context: Context
  ) {}
}

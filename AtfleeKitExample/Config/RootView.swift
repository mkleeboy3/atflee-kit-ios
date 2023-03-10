//
//  RootView.swift
//  iSensSample
//
//  Created by Ming on 2023/01/09.
//

import SwiftUI
import AtfleeKit

struct RootView: View {
  var body: some View {
    SafeAreaInsetsConfiguredView {
      HelpersConfiguredView {
        BluetoothManagersConfiguredView {
          RouteConfiguredView()
        }
      }
      .ignoresSafeArea(.all)
    }
  }
}

// - MARK: Environment Object Related

fileprivate struct HelpersConfiguredView<Content: View>: View {
  @StateObject private var uiHelper = UIHelper.shared
  @StateObject private var popupHelper = PopupHelper.shared
  @StateObject private var toastHelper = ToastHelper.shared
  
  let content: Content
  
  init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content()
  }
  
  var body: some View {
    content
      .toast(
        isShowingToast: toastHelper.isShowingToast,
        toastOptions: toastHelper.toastOptions,
        toastString: toastHelper.toastString
      )
      .dialog(
        isShowing: popupHelper.isShowingDialog,
        dialogOptions: popupHelper.dialogOptions,
        content: {
          AnyView(popupHelper.content)
        }
      )
  }
}

fileprivate struct SafeAreaInsetsConfiguredView<Content: View>: View {
  let content: Content
  
  init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content()
  }
  
  var body: some View {
    GeometryReader { geometry in
      content
        .environmentObject(
          SafeAreaInsets(
            leading: geometry.safeAreaInsets.leading,
            top: geometry.safeAreaInsets.top,
            trailing: geometry.safeAreaInsets.trailing,
            bottom: geometry.safeAreaInsets.bottom
          )
        )
    }
  }
}

fileprivate struct BluetoothManagersConfiguredView<Content: View>: View {
  let content: Content
  
  init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content()
    
    let _ = AtfleeManager.shared
  }
  
  var body: some View {
    content
  }
}

fileprivate struct RouteConfiguredView: View {  
  var body: some View {
    RootRouterView { routeOption in
      routeOption.buildConfiguredView()
    }
  }
}

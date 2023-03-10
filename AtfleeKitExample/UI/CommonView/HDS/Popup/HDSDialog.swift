//
//  HDSDialog.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/13.
//

import SwiftUI

extension View {
  func dialog<Content: View>(
    isShowing: Bool,
    dialogOptions: HDSDialogOptions?,
    @ViewBuilder content: () -> Content
  ) -> some View {
    modifier(
      HDSDialog(
        isShowing: isShowing,
        dialogOptions: dialogOptions,
        dialogContent: content
      )
    )
  }
}

struct HDSDialog<DialogContent: View>: ViewModifier {
  private let router: Router = Router.shared
  private let closeDialog: VoidCallback = PopupHelper.shared.closeDialog
  
  private let isShowing: Bool
  private let dialogOptions: HDSDialogOptions?
  private let dialogContent: DialogContent
  
  init(
    isShowing: Bool,
    dialogOptions: HDSDialogOptions?,
    @ViewBuilder dialogContent: () -> DialogContent
  ) {
    self.isShowing = isShowing
    self.dialogOptions = dialogOptions
    self.dialogContent = dialogContent()
  }
  
  func body(content: Content) -> some View {
    ZStack {
      content
      
      dialogView
    }
  }
  
  private var dialogView: some View {
    ConditionalView(
      isShowing && (dialogOptions != nil),
      trueContent: {
        ZStack {
          dialogBackgroundView
          
          VStack(spacing: 0) {
            SizedView(height: 36)
            
            dialogContent
            
            SizedView(height: 36)
            
            dialogButtonsView
            
            SizedView(height: 24)
          }
          .frame(width: dialogOptions!.dialogWidth)
          .frame(minHeight: 0)
          .background(dialogOptions!.dialogContentBackgroundColor)
          .cornerRadius(dialogOptions!.dialogCornerRadius)
        }
      }
    )
    .animation(AppTheme.defaultAnimation, value: isShowing)
  }
}

extension HDSDialog {
  var dialogBackgroundView: some View {
    dialogOptions!.dialogBackgroundColor
      .contentShape(Rectangle())
      .onTapGesture {
        if (dialogOptions!.dismissable) {
          closeDialog()
        }
      }
  }
  
  var dialogButtonsView: some View {
    HStack(spacing: dialogOptions!.buttonSpacing) {
      ConditionalView(
        dialogOptions!.hasPositiveButton,
        trueContent: {
          HDSButtonView.roundLargeBasic(
            width: .infinity,
            disabled: false,
            label: dialogOptions!.positiveButtonLabel,
            labelFont: dialogOptions!.positiveButtonFont,
            labelPressedFont: dialogOptions!.positiveButtonFont,
            contentHorizontalPadding: 0,
            onPressed: {
              dialogOptions!.onPositiveButtonPressed?()
              if (dialogOptions!.dismissOnButtonPress) {
                closeDialog()
              }
            }
          )
        }
      )
      
      ConditionalView(
        dialogOptions!.hasNegativeButton,
        trueContent: {
          HDSButtonView.roundLargeCancel(
            width: .infinity,
            label: dialogOptions!.negativeButtonLabel,
            labelFont: dialogOptions!.negativeButtonFont,
            labelPressedFont: dialogOptions!.negativeButtonFont,
            contentHorizontalPadding: 0,
            onPressed: {
              dialogOptions!.onNegativeButtonPressed?()
              if (dialogOptions!.dismissOnButtonPress) {
                closeDialog()
              }
            }
          )
        }
      )
    }
    .padding(.horizontal, 24)
  }
}

struct HDSDialogOptions {
  let dismissable: Bool
  let dismissOnButtonPress: Bool
  let dialogWidth: CGFloat
  let dialogCornerRadius: CGFloat
  let dialogContentBackgroundColor: Color
  let dialogBackgroundColor: Color
  let buttonSpacing: CGFloat
  let hasPositiveButton: Bool
  let hasNegativeButton: Bool
  let positiveButtonColor: Color
  let positiveButtonPressedColor: Color
  let negativeButtonColor: Color
  let negativeButtonPressedColor: Color
  let positiveButtonLabel: String
  let negativeButtonLabel: String
  let positiveButtonFont: CustomFont
  let negativeButtonFont: CustomFont
  let onPositiveButtonPressed: VoidCallback?
  let onNegativeButtonPressed: VoidCallback?
  
  init(
    dismissable: Bool = false,
    dismissOnButtonPress: Bool = true,
    dialogWidth: CGFloat = 296,
    dialogCornerRadius: CGFloat = 16,
    dialogContentBackgroundColor: Color = Palette.white100Percent,
    dialogBackgroundColor: Color = Palette.black20Percent,
    buttonSpacing: CGFloat = 8,
    hasPositiveButton: Bool = true,
    hasNegativeButton: Bool = true,
    positiveButtonColor: Color = Palette.primary500,
    positiveButtonPressedColor: Color = Palette.primary300,
    negativeButtonColor: Color = Palette.gray100,
    negativeButtonPressedColor: Color = Palette.gray200,
    positiveButtonLabel: String = "확인",
    negativeButtonLabel: String = "취소",
    positiveButtonFont: CustomFont = Fonts.body1.copyWith(color: Palette.white100Percent),
    negativeButtonFont: CustomFont = Fonts.body1.copyWith(color: Palette.gray900),
    onPositiveButtonPressed: VoidCallback? = nil,
    onNegativeButtonPressed: VoidCallback? = nil
  ) {
    self.dismissable = dismissable
    self.dismissOnButtonPress = dismissOnButtonPress
    self.dialogWidth = dialogWidth
    self.dialogCornerRadius = dialogCornerRadius
    self.dialogContentBackgroundColor = dialogContentBackgroundColor
    self.dialogBackgroundColor = dialogBackgroundColor
    self.buttonSpacing = buttonSpacing
    self.hasPositiveButton = hasPositiveButton
    self.hasNegativeButton = hasNegativeButton
    self.positiveButtonColor = positiveButtonColor
    self.positiveButtonPressedColor = positiveButtonPressedColor
    self.negativeButtonColor = negativeButtonColor
    self.negativeButtonPressedColor = negativeButtonPressedColor
    self.positiveButtonLabel = positiveButtonLabel
    self.negativeButtonLabel = negativeButtonLabel
    self.positiveButtonFont = positiveButtonFont
    self.negativeButtonFont = negativeButtonFont
    self.onPositiveButtonPressed = onPositiveButtonPressed
    self.onNegativeButtonPressed = onNegativeButtonPressed
  }
}

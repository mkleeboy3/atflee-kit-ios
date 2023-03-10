//
//  HDSInputPinNumberCellView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/29.
//

import SwiftUI

struct HDSInputPinNumberCellView: View {
  private static let focusWidthProportionToCellWidth: CGFloat = 28 / 44
  private static let focusVerticalOffsetProportionToCellHeight: CGFloat = 20 / 60
  
  let hasCursorBlinkAnimation: Bool
  let focused: Bool
  let error: Bool
  let state: CellState
  let cellSize: CGSize
  let cellCornerRadius: CGFloat
  let legend: String
  let legendFont: CustomFont
  let backgroundColor: Color
  let positiveColor: Color
  let negativeColor: Color
  
  init(
    hasCursorBlinkAnimation: Bool,
    focused: Bool,
    error: Bool,
    state: CellState,
    cellSize: CGSize = CGSize(width: 44, height: 60),
    cellCornerRadius: CGFloat = 12,
    legend: String,
    legendFont: CustomFont = Fonts.title4.copyWith(color: Palette.white100Percent),
    backgroundColor: Color = Palette.gray100,
    positiveColor: Color = Palette.primary500,
    negativeColor: Color = Palette.feedbackRed500
  ) {
    self.hasCursorBlinkAnimation = hasCursorBlinkAnimation
    self.focused = focused
    self.error = error
    self.state = state
    self.cellSize = cellSize
    self.cellCornerRadius = cellCornerRadius
    self.legend = legend
    self.legendFont = legendFont
    self.backgroundColor = backgroundColor
    self.positiveColor = positiveColor
    self.negativeColor = negativeColor
  }
  
  var body: some View {
    state.getView(
      hasCursorBlinkAnimation: hasCursorBlinkAnimation,
      focused: focused,
      error: error,
      cellSize: cellSize,
      cellCornerRadius: cellCornerRadius,
      legend: legend,
      legendFont: legendFont,
      backgroundColor: backgroundColor,
      positiveColor: positiveColor,
      negativeColor: negativeColor
    )
  }
}

extension HDSInputPinNumberCellView {
  enum CellState {
    case empty
    case focus
    case entered
    
    @ViewBuilder
    func getView(
      hasCursorBlinkAnimation: Bool,
      focused: Bool,
      error: Bool,
      cellSize: CGSize,
      cellCornerRadius: CGFloat,
      legend: String,
      legendFont: CustomFont,
      backgroundColor: Color,
      positiveColor: Color,
      negativeColor: Color
    ) -> some View {
      switch (self) {
        case .empty:
          CellBackgroundView(
            hasCursorBlinkAnimation: hasCursorBlinkAnimation,
            cellSize: cellSize,
            cellCornerRadius: cellCornerRadius,
            color: backgroundColor
          )
          
        case .focus:
          CellBackgroundView(
            hasCursorBlinkAnimation: hasCursorBlinkAnimation,
            cellSize: cellSize,
            cellCornerRadius: cellCornerRadius,
            color: backgroundColor,
            focused: focused,
            focusColor: error ? negativeColor : positiveColor
          )
          
        case .entered:
          ZStack {
            CellBackgroundView(
              hasCursorBlinkAnimation: hasCursorBlinkAnimation,
              cellSize: cellSize,
              cellCornerRadius: cellCornerRadius,
              color: error ? negativeColor : positiveColor
            )
            
            Text(legend)
              .customFont(legendFont)
          }
      }
    }
  }
  
  private struct CellBackgroundView: View {
    @State var visible: Bool = true
    
    let hasCursorBlinkAnimation: Bool
    let cellSize: CGSize
    let cellCornerRadius: CGFloat
    let color: Color
    let focused: Bool
    let focusColor: Color?
    
    init(
      hasCursorBlinkAnimation: Bool,
      cellSize: CGSize,
      cellCornerRadius: CGFloat,
      color: Color,
      focused: Bool = false,
      focusColor: Color? = nil
    ) {
      self.hasCursorBlinkAnimation = hasCursorBlinkAnimation
      self.cellSize = cellSize
      self.cellCornerRadius = cellCornerRadius
      self.color = color
      self.focused = focused
      self.focusColor = focusColor
    }
    
    var body: some View {
      ZStack {
        RoundedRectangle(cornerRadius: cellCornerRadius)
          .frame(width: cellSize.width, height: cellSize.height)
          .foregroundColor(color)
        
        ConditionalView(
          focused && (focusColor != nil),
          trueContent: {
            Rectangle()
              .frame(
                width: focusWidthProportionToCellWidth * cellSize.width,
                height: 2
              )
              .foregroundColor(focusColor!)
              .offset(y: focusVerticalOffsetProportionToCellHeight * cellSize.height)
              .opacity(visible ? 1 : 0)
              .if(
                hasCursorBlinkAnimation,
                transform: { view in
                  view
                    .animation(
                      AppTheme.defaultCursorAnimation.repeatForever(),
                      value: visible
                    )
                    .onAppear {
                      if (!visible) {
                        DispatchQueue.main.async {
                          visible = true
                        }
                      }
                      withAnimation {
                        visible = false
                      }
                    }
                }
              )
          }
        )
      }
      .animation(AppTheme.defaultAnimation, value: color)
      .animation(AppTheme.defaultAnimation, value: focused)
      .animation(AppTheme.defaultAnimation, value: focusColor)
    }
  }
}

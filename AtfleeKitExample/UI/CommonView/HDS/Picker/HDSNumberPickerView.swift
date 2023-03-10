//
//  HDSNumberPickerView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/08.
//

import SwiftUI

struct HDSNumberPickerView<Content: View>: View {
  @Binding var selectedIndex: Int
  
  let numberOfRows: Int
  let numberOfRowsVisibleInScrollView: Int
  let scrollViewWidth: CGFloat
  let scrollViewRowHeight: CGFloat
  let labelMap: [Int: String]?
  let font: CustomFont
  let selectedFont: CustomFont
  let pickerBackgroundColor: Color
  let pickerOverlay: Content
  
  init(
    selectedIndex: Binding<Int>,
    numberOfRows: Int,
    numberOfRowsVisibleInScrollView: Int = 3,
    scrollViewWidth: CGFloat,
    scrollViewRowHeight: CGFloat,
    labelMap: [Int : String]? = nil,
    font: CustomFont = Fonts.detail4.copyWith(color: Palette.gray400),
    selectedFont: CustomFont = Fonts.body1,
    pickerBackgroundColor: Color = Palette.transparent,
    @ViewBuilder pickerOverlay: () -> Content = {
      RoundedRectangle(cornerRadius: 5)
        .foregroundColor(Palette.gray100)
        .frame(width: 336, height: 51)
    }
  ) {
    self._selectedIndex = selectedIndex
    self.numberOfRows = numberOfRows
    self.numberOfRowsVisibleInScrollView = numberOfRowsVisibleInScrollView
    self.scrollViewWidth = scrollViewWidth
    self.scrollViewRowHeight = scrollViewRowHeight
    self.labelMap = labelMap
    self.font = font
    self.selectedFont = selectedFont
    self.pickerBackgroundColor = pickerBackgroundColor
    self.pickerOverlay = pickerOverlay()
  }
  
  private func assert() {
    
  }
  
  private var scrollViewHeight: CGFloat {
    scrollViewRowHeight * CGFloat(numberOfRowsVisibleInScrollView)
  }
  
  var body: some View {
    ZStack {
      pickerBackgroundColor
        .frame(
          width: scrollViewWidth,
          height: scrollViewHeight
        )
      
      pickerOverlay
      
      _PickerScrollView(
        selectedIndex: $selectedIndex,
        numberOfRows: numberOfRows,
        numberOfRowsVisibleInScrollView: numberOfRowsVisibleInScrollView,
        scrollViewWidth: scrollViewWidth,
        scrollViewRowHeight: scrollViewRowHeight,
        labelMap: labelMap,
        font: font,
        selectedFont: selectedFont
      )
      .frame(
        width: scrollViewWidth,
        height: scrollViewHeight
      )
    }
  }
}

fileprivate struct _PickerScrollView: UIViewRepresentable {
  @Binding var selectedIndex: Int
  
  let numberOfRows: Int
  let numberOfRowsVisibleInScrollView: Int
  let scrollViewWidth: CGFloat
  let scrollViewRowHeight: CGFloat
  let labelMap: [Int: String]?
  let font: CustomFont
  let selectedFont: CustomFont
  
  init(
    selectedIndex: Binding<Int>,
    numberOfRows: Int,
    numberOfRowsVisibleInScrollView: Int,
    scrollViewWidth: CGFloat,
    scrollViewRowHeight: CGFloat,
    labelMap: [Int : String]?,
    font: CustomFont,
    selectedFont: CustomFont
  ) {
    self._selectedIndex = selectedIndex
    self.numberOfRows = numberOfRows
    self.numberOfRowsVisibleInScrollView = numberOfRowsVisibleInScrollView
    self.scrollViewWidth = scrollViewWidth
    self.scrollViewRowHeight = scrollViewRowHeight
    self.labelMap = labelMap
    self.font = font
    self.selectedFont = selectedFont
  }
  
  private var numberOfRowsToPad: Int {
    Int(round(CGFloat((numberOfRowsVisibleInScrollView - 1) / 2)))
  }
  
  private var getEmptyRowView: UIView {
    let view = UIView(frame: CGRect(
      origin: .zero,
      size: CGSize(width: scrollViewWidth, height: scrollViewRowHeight)
    ))
    view.backgroundColor = Palette.transparent.toUIColor()
    
    return view
  }
  
  private func getScrollViewRowView(for index: Int) -> UIView {
    let view = UILabel(frame: CGRect(
      origin: .zero,
      size: CGSize(width: scrollViewWidth, height: scrollViewRowHeight)
    ))
    view.tag = index
    view.textAlignment = .center
    view.backgroundColor = Palette.transparent.toUIColor()
    view.numberOfLines = 1
    
    view.text = labelMap?[index] ?? String(index)
    view.font = (index == selectedIndex) ? selectedFont.toUIFont() : font.toUIFont()
    view.textColor = (index == selectedIndex)
    ? selectedFont.color.toUIColor()
    : font.color.toUIColor()
    
    return view
  }
  
  private func addEmptyRows(
    to scrollView: UIScrollView,
    for iteration: Int
  ) {
    for _ in 0..<iteration {
      scrollView.addSubviewToBottom(getEmptyRowView)
    }
  }
  
  private func addScrollViewRows(to scrollView: UIScrollView) {
    for index in 0..<numberOfRows {
      scrollView.addSubviewToBottom(getScrollViewRowView(for: index))
    }
  }
  
  func makeUIView(context: UIViewRepresentableContext<_PickerScrollView>) -> UIScrollView {
    let scrollView = UIScrollView(frame:.zero)
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    
    addEmptyRows(to: scrollView, for: numberOfRowsToPad)
    addScrollViewRows(to: scrollView)
    addEmptyRows(to: scrollView, for: numberOfRowsToPad)
    
    scrollView.updateContentSize()
    
    scrollView.delegate = context.coordinator
    
    return scrollView
  }
  
  func updateUIView(
    _ uiView: UIScrollView,
    context: Context
  ) {
    context.coordinator.scrollToIndex(on: uiView, to: selectedIndex)
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(
      selectedIndex: $selectedIndex,
      numberOfRows: numberOfRows,
      numberOfRowsToPad: numberOfRowsToPad,
      numberOfRowsVisibleInScrollView: numberOfRowsVisibleInScrollView,
      rowHeight: scrollViewRowHeight,
      font: font,
      selectedFont: selectedFont
    )
  }
  
  class Coordinator: NSObject, UIScrollViewDelegate {
    @Binding var selectedIndex: Int
    
    let numberOfRows: Int
    let numberOfRowsToPad: Int
    let numberOfRowsVisibleInScrollView: Int
    let rowHeight: CGFloat
    let font: CustomFont
    let selectedFont: CustomFont
    
    init(
      selectedIndex: Binding<Int>,
      numberOfRows: Int,
      numberOfRowsToPad: Int,
      numberOfRowsVisibleInScrollView: Int,
      rowHeight: CGFloat,
      font: CustomFont,
      selectedFont: CustomFont
    ) {
      self._selectedIndex = selectedIndex
      self.numberOfRows = numberOfRows
      self.numberOfRowsToPad = numberOfRowsToPad
      self.numberOfRowsVisibleInScrollView = numberOfRowsVisibleInScrollView
      self.rowHeight = rowHeight
      self.font = font
      self.selectedFont = selectedFont
    }
    
    fileprivate func scrollToIndex(
      on scrollView: UIScrollView,
      to index: Int
    ) {
      guard 0 <= index && index < numberOfRows else {
        setValueToBinding(from: scrollView)
        return
      }
      
      let contentOffset = scrollView.contentOffset
      let indexOffsetY = CGFloat(index) * rowHeight
      scrollView.setContentOffset(
        CGPointMake(contentOffset.x, indexOffsetY),
        animated: true
      )
    }
    
    private func setValueToBinding(from scrollView: UIScrollView) {
      let currentIndex = getRowIndex(from: scrollView)
      if (currentIndex != selectedIndex) {
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.selectedIndex = currentIndex
        }
      }
    }
    
    private func getRowIndex(from scrollView: UIScrollView) -> Int {
      let contentOffset = scrollView.contentOffset
      let contentOffsetY = contentOffset.y
      
      return Int(round(contentOffsetY / rowHeight))
    }
    
    private func didStopScrolling(_ scrollView: UIScrollView) {
      let contentOffset = scrollView.contentOffset
      let roundedOffset = getRowIndex(from: scrollView)
      let roundedOffsetY = CGFloat(roundedOffset) * rowHeight
      scrollView.setContentOffset(
        CGPointMake(contentOffset.x, roundedOffsetY),
        animated: true
      )
      
      setValueToBinding(from: scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let currentIndex = getRowIndex(from: scrollView)
      let totalNumberOfRows = numberOfRows + numberOfRowsToPad * 2
      for index in 0..<totalNumberOfRows {
        if let labelView = scrollView.subviews[index] as? UILabel {
          if (labelView.tag == currentIndex) {
            DispatchQueue.main.async { [weak self] in
              guard let self = self else { return }
              labelView.font = self.selectedFont.toUIFont()
              labelView.textColor = self.selectedFont.color.toUIColor()
            }
          } else {
            DispatchQueue.main.async { [weak self] in
              guard let self = self else { return }
              labelView.font = self.font.toUIFont()
              labelView.textColor = self.font.color.toUIColor()
            }
          }
        }
      }
    }
    
    func scrollViewDidEndDragging(
      _ scrollView: UIScrollView,
      willDecelerate decelerate: Bool
    ) {
      if (!decelerate) {
        didStopScrolling(scrollView)
      }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      didStopScrolling(scrollView)
    }
  }
}

fileprivate extension UIView {
  func addSubviewToBottom(_ view: UIView) {
    var maxY = CGFloat(0)
    for subview in self.subviews {
      if maxY < subview.frame.maxY{
        maxY = subview.frame.maxY
      }
    }
    
    view.frame.origin.y = maxY
    self.addSubview(view)
  }
}

fileprivate extension UIScrollView {
  func updateContentSize() {
    let contentRect: CGRect = subviews.reduce(into: .zero) { rect, view in
      rect = rect.union(view.frame)
    }
    contentSize = contentRect.size
  }
}

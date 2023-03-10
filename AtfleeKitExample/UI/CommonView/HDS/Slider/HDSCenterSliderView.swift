//
//  HDSCenterSliderView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/03.
//

import SwiftUI

struct HDSCenterSliderView: UIViewRepresentable {
  @Binding var sliderValue: Float
  
  let disabled: Bool
  let isValueContinuous: Bool
  let step: Int
  let rangeMagnitude: Float
  let trackHeight: CGFloat
  let trackCenterThumbRadius: CGFloat
  let trackColor: Color
  let trackSecondaryColor: Color
  let thumbColor: Color
  let thumbCoronalColor: Color
  let thumbInnerColor: Color
  let thumbPressedColor: Color
  let thumbPressedCoronalColor: Color
  let thumbPressedInnerColor: Color
  let thumbRadius: CGFloat
  let thumbCoronalRadius: CGFloat
  let thumbInnerRadius: CGFloat
  
  init(
    sliderValue: Binding<Float>,
    disabled: Bool = false,
    isValueContinuous: Bool = false,
    step: Int = 1,
    rangeMagnitude: Float = 5,
    trackHeight: CGFloat = 8,
    trackCenterThumbRadius: CGFloat = 8,
    trackColor: Color = Palette.primary500,
    trackSecondaryColor: Color = Palette.gray100,
    thumbColor: Color = Palette.primary500,
    thumbCoronalColor: Color = Palette.transparent,
    thumbInnerColor: Color = Palette.white100Percent,
    thumbPressedColor: Color? = nil,
    thumbPressedCoronalColor: Color? = Palette.primary500.opacity(0.1),
    thumbPressedInnerColor: Color? = nil,
    thumbRadius: CGFloat = 14,
    thumbCoronalRadius: CGFloat = 28,
    thumbInnerRadius: CGFloat = 6
  ) {
    self._sliderValue = sliderValue
    self.disabled = disabled
    self.isValueContinuous = isValueContinuous
    self.step = step
    self.rangeMagnitude = rangeMagnitude
    self.trackHeight = trackHeight
    self.trackCenterThumbRadius = trackCenterThumbRadius
    self.trackColor = trackColor
    self.trackSecondaryColor = trackSecondaryColor
    self.thumbColor = thumbColor
    self.thumbCoronalColor = thumbCoronalColor
    self.thumbInnerColor = thumbInnerColor
    self.thumbPressedColor = thumbPressedColor ?? thumbColor
    self.thumbPressedCoronalColor = thumbPressedCoronalColor ?? thumbCoronalColor
    self.thumbPressedInnerColor = thumbPressedInnerColor ?? thumbInnerColor
    self.thumbRadius = thumbRadius
    self.thumbCoronalRadius = thumbCoronalRadius
    self.thumbInnerRadius = thumbInnerRadius
    
    assert()
  }
  
  private func assert() {
    guard rangeMagnitude > 0 else {
      fatalError("rangeMagnitude must be a positive value")
    }
    
    guard step >= 0 else {
      fatalError("step must be a positive number")
    }
    
    guard rangeMagnitude >= Float(step) else {
      fatalError("step must be smaller than or equal to rangeMagnitude")
    }
    
    guard trackHeight > 0 else {
      fatalError("trackHeight must be greater than 0")
    }
    
    guard trackCenterThumbRadius >= 0 else {
      fatalError("trackLeftThumbRadius must be greater than or equal to 0")
    }
    
    guard thumbInnerRadius <= thumbRadius else {
      fatalError("thumbInnerRadius must be smaller than or equal to thumbRadius")
    }
    
    guard thumbRadius <= thumbCoronalRadius else {
      fatalError("thumbRadius must be smaller than or equal to thumbCoronalRadius")
    }
    
    guard thumbInnerRadius <= thumbCoronalRadius else {
      fatalError("thumbInnerRadius must be smaller than or equal to thumbCoronalRadius")
    }
  }
  
  func makeUIView(
    context: UIViewRepresentableContext<HDSCenterSliderView>
  ) -> _CustomizedCenterUISlider {
    let slider = _CustomizedCenterUISlider(
      sliderValue: $sliderValue,
      isValueContinuous: isValueContinuous,
      step: step,
      rangeMagnitude: rangeMagnitude,
      trackHeight: trackHeight,
      trackCenterThumbRadius: trackCenterThumbRadius,
      trackColor: trackColor.toUIColor(),
      trackSecondaryColor: trackSecondaryColor.toUIColor(),
      thumbColor: thumbColor.toUIColor(),
      thumbCoronalColor: thumbCoronalColor.toUIColor(),
      thumbInnerColor: thumbInnerColor.toUIColor(),
      thumbPressedColor: thumbPressedColor.toUIColor(),
      thumbPressedCoronalColor: thumbPressedCoronalColor.toUIColor(),
      thumbPressedInnerColor: thumbPressedInnerColor.toUIColor(),
      thumbRadius: thumbRadius,
      thumbCoronalRadius: thumbCoronalRadius,
      thumbInnerRadius: thumbInnerRadius
    )
    
    slider.minimumValue = -rangeMagnitude
    slider.maximumValue = rangeMagnitude
    slider.isUserInteractionEnabled = !disabled
    
    return slider
  }
  
  func updateUIView(
    _ uiView: _CustomizedCenterUISlider,
    context: Context
  ) {
    uiView.value = sliderValue
    uiView.isUserInteractionEnabled = !disabled
  }
}

class _CustomizedCenterUISlider: UISlider {
  @Binding var sliderValue: Float
  
  let isValueContinuous: Bool
  let step: Int
  let rangeMagnitude: Float
  let trackHeight: CGFloat
  let trackCenterThumbRadius: CGFloat
  let trackColor: UIColor
  let trackSecondaryColor: UIColor
  let thumbColor: UIColor
  let thumbCoronalColor: UIColor
  let thumbInnerColor: UIColor
  let thumbPressedColor: UIColor
  let thumbPressedCoronalColor: UIColor
  let thumbPressedInnerColor: UIColor
  let thumbRadius: CGFloat
  let thumbCoronalRadius: CGFloat
  let thumbInnerRadius: CGFloat
  
  private let baseTrackLayer = CALayer()
  private let trackCenterThumbLayer = CALayer()
  private let trackLayer = CALayer()
  
  var getTrackRect: CGRect {
    CGRect(
      x: frame.origin.x + thumbCoronalRadius,
      y: frame.origin.y + thumbCoronalRadius - trackHeight / 2,
      width: frame.width - thumbCoronalRadius * 2,
      height: trackHeight
    )
  }
  
  var getTrackCenterThumbRect: CGRect {
    let trackRect = getTrackRect
    return CGRect(
      x: trackRect.midX - trackCenterThumbRadius,
      y: trackRect.origin.y + trackHeight / 2 - trackCenterThumbRadius,
      width: trackCenterThumbRadius * 2,
      height: trackCenterThumbRadius * 2
    )
  }
  
  init(
    sliderValue: Binding<Float>,
    isValueContinuous: Bool,
    step: Int,
    rangeMagnitude: Float,
    trackHeight: CGFloat,
    trackCenterThumbRadius: CGFloat,
    trackColor: UIColor,
    trackSecondaryColor: UIColor,
    thumbColor: UIColor,
    thumbCoronalColor: UIColor,
    thumbInnerColor: UIColor,
    thumbPressedColor: UIColor,
    thumbPressedCoronalColor: UIColor,
    thumbPressedInnerColor: UIColor,
    thumbRadius: CGFloat,
    thumbCoronalRadius: CGFloat,
    thumbInnerRadius: CGFloat
  ) {
    self._sliderValue = sliderValue
    self.isValueContinuous = isValueContinuous
    self.step = step
    self.rangeMagnitude = rangeMagnitude
    self.trackHeight = trackHeight
    self.trackCenterThumbRadius = trackCenterThumbRadius
    self.trackColor = trackColor
    self.trackSecondaryColor = trackSecondaryColor
    self.thumbColor = thumbColor
    self.thumbCoronalColor = thumbCoronalColor
    self.thumbInnerColor = thumbInnerColor
    self.thumbPressedColor = thumbPressedColor
    self.thumbPressedCoronalColor = thumbPressedCoronalColor
    self.thumbPressedInnerColor = thumbPressedInnerColor
    self.thumbRadius = thumbRadius
    self.thumbCoronalRadius = thumbCoronalRadius
    self.thumbInnerRadius = thumbInnerRadius
    
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    buildView()
    addValueChangeListener()
    reconfigureViewToBaseSliderValue()
  }
  
  private func buildView() {
    clearOriginalView()
    buildBaseTrackView()
    buildTrackCenterThumbView()
    buildThumbView()
    buildTrackView()
  }
  
  private func clearOriginalView() {
    tintColor = Palette.transparent.toUIColor()
    maximumTrackTintColor = Palette.transparent.toUIColor()
    minimumTrackTintColor = Palette.transparent.toUIColor()
    backgroundColor = Palette.transparent.toUIColor()
    thumbTintColor = Palette.transparent.toUIColor()
  }
  
  private func buildBaseTrackView() {
    baseTrackLayer.masksToBounds = true
    baseTrackLayer.backgroundColor = trackSecondaryColor.cgColor
    baseTrackLayer.frame = getTrackRect
    baseTrackLayer.cornerRadius = baseTrackLayer.frame.height / 2
    layer.insertSublayer(baseTrackLayer, at: 0)
  }
  
  private func buildTrackCenterThumbView() {
    let trackRect = getTrackRect
    trackCenterThumbLayer.backgroundColor = trackColor.cgColor
    trackCenterThumbLayer.cornerRadius = trackCenterThumbRadius
    trackCenterThumbLayer.frame = CGRect(
      x: trackRect.midX - trackCenterThumbRadius,
      y: trackRect.origin.y + trackHeight / 2 - trackCenterThumbRadius,
      width: trackCenterThumbRadius * 2,
      height: trackCenterThumbRadius * 2
    )
    layer.insertSublayer(trackCenterThumbLayer, at: 1)
  }
  
  private func buildThumbView() {
    setThumbImage(
      CustomizedSliderThumb(
        thumbColor: thumbColor,
        thumbCoronalColor: thumbCoronalColor,
        thumbInnerColor: thumbInnerColor,
        thumbPressedColor: thumbPressedColor,
        thumbPressedCoronalColor: thumbPressedCoronalColor,
        thumbPressedInnerColor: thumbPressedInnerColor,
        thumbRadius: thumbRadius,
        thumbCoronalRadius: thumbCoronalRadius,
        thumbInnerRadius: thumbInnerRadius
      ).toUIImage(),
      for: .normal
    )
    setThumbImage(
      CustomizedSliderThumb(
        thumbColor: thumbColor,
        thumbCoronalColor: thumbCoronalColor,
        thumbInnerColor: thumbInnerColor,
        thumbPressedColor: thumbPressedColor,
        thumbPressedCoronalColor: thumbPressedCoronalColor,
        thumbPressedInnerColor: thumbPressedInnerColor,
        thumbRadius: thumbRadius,
        thumbCoronalRadius: thumbCoronalRadius,
        thumbInnerRadius: thumbInnerRadius,
        pressed: true
      ).toUIImage(),
      for: .highlighted
    )
  }
  
  private func buildTrackView() {
    trackLayer.backgroundColor = trackColor.cgColor
    trackLayer.frame = getTrackRect
    trackLayer.cornerRadius = trackLayer.frame.height / 2
    layer.insertSublayer(trackLayer, at: 2)
  }
  
  private func addValueChangeListener() {
    addTarget(
      self,
      action: #selector(valueChanged(_:)),
      for: .valueChanged
    )
  }
  
  @objc private func valueChanged(_ sender: _CustomizedCenterUISlider) {
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    
    if !isValueContinuous {
      let roundedValue = round(sender.value / Float(step)) * Float(step)
      if roundedValue == 0 {
        sender.value = 0
      } else {
        sender.value = roundedValue
      }
    }
    
    DispatchQueue.main.async { [unowned self] in
      self.sliderValue = sender.value
    }
    
    if
      isValueContinuous ||
        Double(sender.value).truncatingRemainder(dividingBy: Double(step)) == 0 {
      trackLayer.frame = calculateTractRect()
    }
    
    CATransaction.commit()
  }
  
  private func reconfigureViewToBaseSliderValue() {
    valueChanged(self)
  }
  
  private func calculateTractRect() -> CGRect {
    let currentThumbRect = thumbRect(
      forBounds: bounds,
      trackRect: trackRect(forBounds: bounds),
      value: value
    )
    let trackRect = getTrackRect
    let trackCenterThumbRect = getTrackCenterThumbRect
    return CGRect(
      x: trackCenterThumbRect.origin.x + trackCenterThumbRadius,
      y: trackRect.origin.y,
      width: currentThumbRect.midX - trackCenterThumbRect.midX,
      height: trackRect.height
    )
  }
}

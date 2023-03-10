//
//  HDSSliderView.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/02/02.
//

import SwiftUI

struct HDSSliderView: UIViewRepresentable {
  @Binding var sliderValue: Float
  
  let disabled: Bool
  let isValueContinuous: Bool
  let step: Int
  let minimumValue: Float
  let maximumValue: Float
  let trackHeight: CGFloat
  let trackLeftThumbRadius: CGFloat
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
    minimumValue: Float = 0,
    maximumValue: Float = 10,
    trackHeight: CGFloat = 8,
    trackLeftThumbRadius: CGFloat = 8,
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
    self.minimumValue = minimumValue
    self.maximumValue = maximumValue
    self.trackHeight = trackHeight
    self.trackLeftThumbRadius = trackLeftThumbRadius
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
    guard minimumValue <= maximumValue else {
      fatalError("maximumValue must be greater than or equal to minimumValue")
    }
    
    guard step >= 0 else {
      fatalError("step must be a positive number")
    }
    
    guard maximumValue - minimumValue >= Float(step) else {
      fatalError("step must be smaller than or equal to the entire range")
    }
    
    guard trackHeight > 0 else {
      fatalError("trackHeight must be greater than 0")
    }
    
    guard trackLeftThumbRadius >= 0 else {
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
  
  func makeUIView(context: UIViewRepresentableContext<HDSSliderView>) -> _CustomizedUISlider {
    let slider = _CustomizedUISlider(
      sliderValue: $sliderValue,
      isValueContinuous: isValueContinuous,
      step: step,
      trackHeight: trackHeight,
      trackLeftThumbRadius: trackLeftThumbRadius,
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
    
    slider.minimumValue = minimumValue
    slider.maximumValue = maximumValue
    slider.isUserInteractionEnabled = !disabled
    
    return slider
  }
  
  func updateUIView(
    _ uiView: _CustomizedUISlider,
    context: Context
  ) {
    uiView.value = sliderValue
    uiView.isUserInteractionEnabled = !disabled
  }
}

class _CustomizedUISlider: UISlider {
  @Binding var sliderValue: Float
  
  let isValueContinuous: Bool
  let step: Int
  let trackHeight: CGFloat
  let trackLeftThumbRadius: CGFloat
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
  private let trackLeftThumbLayer = CALayer()
  private let trackLayer = CALayer()
  
  var getTrackRect: CGRect {
    CGRect(
      x: frame.origin.x + thumbCoronalRadius,
      y: frame.origin.y + thumbCoronalRadius - trackHeight / 2,
      width: frame.width - thumbCoronalRadius * 2,
      height: trackHeight
    )
  }
  
  init(
    sliderValue: Binding<Float>,
    isValueContinuous: Bool,
    step: Int,
    trackHeight: CGFloat,
    trackLeftThumbRadius: CGFloat,
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
    self.trackHeight = trackHeight
    self.trackLeftThumbRadius = trackLeftThumbRadius
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
    buildTrackLeftThumbView()
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
  
  private func buildTrackLeftThumbView() {
    let trackRect = getTrackRect
    trackLeftThumbLayer.backgroundColor = trackColor.cgColor
    trackLeftThumbLayer.cornerRadius = trackLeftThumbRadius
    trackLeftThumbLayer.frame = CGRect(
      x: trackRect.origin.x - trackLeftThumbRadius,
      y: trackRect.origin.y + trackHeight / 2 - trackLeftThumbRadius,
      width: trackLeftThumbRadius * 2,
      height: trackLeftThumbRadius * 2
    )
    layer.insertSublayer(trackLeftThumbLayer, at: 1)
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
  
  @objc private func valueChanged(_ sender: _CustomizedUISlider) {
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    
    if !isValueContinuous {
      let roundedValue = round(sender.value / Float(step)) * Float(step)
      sender.value = roundedValue
    }
    
    DispatchQueue.main.async { [unowned self] in
      self.sliderValue = sender.value
    }
    
    if
      isValueContinuous ||
        Double(sender.value).truncatingRemainder(dividingBy: Double(step)) == 0 {
      trackLayer.frame = calculateTrackRect()
    }
    
    CATransaction.commit()
  }
  
  private func reconfigureViewToBaseSliderValue() {
    valueChanged(self)
  }
  
  private func calculateTrackRect() -> CGRect {
    let currentThumbRect = thumbRect(
      forBounds: bounds,
      trackRect: trackRect(forBounds: bounds),
      value: value
    )
    let trackRect = getTrackRect
    return CGRect(
      x: trackRect.origin.x,
      y: trackRect.origin.y,
      width: currentThumbRect.midX - thumbCoronalRadius,
      height: trackRect.height
    )
  }
}

class CustomizedSliderThumb: UIView {
  let thumbColor: UIColor
  let thumbCoronalColor: UIColor
  let thumbInnerColor: UIColor
  let thumbPressedColor: UIColor
  let thumbPressedCoronalColor: UIColor
  let thumbPressedInnerColor: UIColor
  let thumbRadius: CGFloat
  let thumbCoronalRadius: CGFloat
  let thumbInnerRadius: CGFloat
  let pressed: Bool
  
  init(
    thumbColor: UIColor,
    thumbCoronalColor: UIColor,
    thumbInnerColor: UIColor,
    thumbPressedColor: UIColor,
    thumbPressedCoronalColor: UIColor,
    thumbPressedInnerColor: UIColor,
    thumbRadius: CGFloat,
    thumbCoronalRadius: CGFloat,
    thumbInnerRadius: CGFloat,
    pressed: Bool = false
  ) {
    self.thumbColor = thumbColor
    self.thumbCoronalColor = thumbCoronalColor
    self.thumbInnerColor = thumbInnerColor
    self.thumbPressedColor = thumbPressedColor
    self.thumbPressedCoronalColor = thumbPressedCoronalColor
    self.thumbPressedInnerColor = thumbPressedInnerColor
    self.thumbRadius = thumbRadius
    self.thumbCoronalRadius = thumbCoronalRadius
    self.thumbInnerRadius = thumbInnerRadius
    self.pressed = pressed
    
    super.init(frame: .zero)
    
    buildView()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func buildView() {
    frame = CGRect(
      x: 0,
      y: 0,
      width: thumbCoronalRadius * 2,
      height: thumbCoronalRadius * 2
    )
    backgroundColor = pressed ? thumbPressedCoronalColor : thumbCoronalColor
    layer.cornerRadius = thumbCoronalRadius
    
    buildThumbView()
    
    buildThumbInnerView()
  }
  
  private func buildThumbView() {
    let thumbView = UIView(frame: CGRect(
      x: frame.midX - thumbRadius,
      y: frame.midY - thumbRadius,
      width: thumbRadius * 2,
      height: thumbRadius * 2
    ))
    thumbView.backgroundColor = pressed ? thumbPressedColor : thumbColor
    thumbView.layer.cornerRadius = thumbRadius
    
    addSubview(thumbView)
  }
  
  private func buildThumbInnerView() {
    let thumbInnerView = UIView(frame: CGRect(
      x: frame.midX - thumbInnerRadius,
      y: frame.midY - thumbInnerRadius,
      width: thumbInnerRadius * 2,
      height: thumbInnerRadius * 2
    ))
    thumbInnerView.backgroundColor = pressed ? thumbPressedInnerColor : thumbInnerColor
    thumbInnerView.layer.cornerRadius = thumbInnerRadius
    
    addSubview(thumbInnerView)
  }
}

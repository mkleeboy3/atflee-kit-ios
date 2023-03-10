//
//  Palette.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/09.
//

import Foundation
import SwiftUI

struct Palette {
  // Design colors
  static let black01Basic = Color(red: 0, green: 0, blue: 0).opacity(1.0)
  static let black02Pressed = Color(red: 0, green: 0, blue: 0).opacity(0.5)
  static let black03Floating = Color(red: 0, green: 0, blue: 0).opacity(1.0)
  static let greyChartLine = Color(red: 230/255, green: 230/255, blue: 230/255).opacity(1.0)
  static let grey01Bg = Color(red: 247/255, green: 247/255, blue: 247/255).opacity(1.0)
  static let grey02Line = Color(red: 229/255, green: 229/255, blue: 229/255).opacity(1.0)
  static let grey03Icon = Color(red: 204/255, green: 204/255, blue: 204/255).opacity(1.0)
  static let grey04Inactive = Color(red: 153/255, green: 153/255, blue: 153/255).opacity(1.0)
  static let grey05Subtext = Color(red: 68/255, green: 68/255, blue: 68/255).opacity(1.0)
  static let white01Basic = Color(red: 255/255, green: 255/255, blue: 255/255).opacity(1.0)
  static let white02Floating = Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.95)
  static let white03Pressed = Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.5)
  static let red01Highlight = Color(red: 252/255, green: 236/255, blue: 234/255).opacity(1.0)
  static let red02Light = Color(red: 247/255, green: 181/255, blue: 174/255).opacity(1.0)
  static let red03Basic = Color(red: 234/255, green: 69/255, blue: 53/255).opacity(1.0)
  static let red04Dark = Color(red: 163/255, green: 48/255, blue: 37/255).opacity(1.0)
  static let retroPink01Highlight = Color(red: 254/255, green: 243/255, blue: 250/255).opacity(1.0)
  static let retroPink02Light = Color(red: 252/255, green: 210/255, blue: 238/255).opacity(1.0)
  static let retroPink03Basic = Color(red: 247/255, green: 142/255, blue: 213/255).opacity(1.0)
  static let retroPink04Dark = Color(red: 194/255, green: 88/255, blue: 160/255).opacity(1.0)
  static let retroBlue01Highlight = Color(red: 238/255, green: 241/255, blue: 251/255).opacity(1.0)
  static let retroBlue02Light = Color(red: 191/255, green: 199/255, blue: 243/255).opacity(1.0)
  static let retroBlue03Basic = Color(red: 94/255, green: 115/255, blue: 224/255).opacity(1.0)
  static let retroBlue04Dark = Color(red: 65/255, green: 80/255, blue: 156/255).opacity(1.0)
  static let retroMint01Highlight = Color(red: 240/255, green: 252/255, blue: 248/255).opacity(1.0)
  static let retroMint02Light = Color(red: 198/255, green: 245/255, blue: 227/255).opacity(1.0)
  static let retroMint03Basic = Color(red: 113/255, green: 230/255, blue: 185/255).opacity(1.0)
  static let retroMint04Dark = Color(red: 78/255, green: 160/255, blue: 129/255).opacity(1.0)
  static let retroOrange01Highlight = Color(red: 254/255, green: 245/255, blue: 244/255).opacity(1.0)
  static let retroOrange02Light = Color(red: 251/255, green: 217/255, blue: 213/255).opacity(1.0)
  static let retroOrange03Basic = Color(red: 246/255, green: 159/255, blue: 150/255).opacity(1.0)
  static let retroOrange04Dark = Color(red: 171/255, green: 110/255, blue: 104/255).opacity(1.0)
  static let retroYellow01Highlight = Color(red: 255/255, green: 250/255, blue: 242/255).opacity(1.0)
  static let retroYellow02Light = Color(red: 255/255, green: 235/255, blue: 205/255).opacity(1.0)
  static let retroYellow03Basic = Color(red: 255/255, green: 205/255, blue: 129/255).opacity(1.0)
  static let retroYellow04Dark = Color(red: 178/255, green: 143/255, blue: 90/255).opacity(1.0)
  static let retroGreen01Highlight = Color(red: 230/255, green: 244/255, blue: 246/255).opacity(1.0)
  static let retroGreen02Light = Color(red: 156/255, green: 214/255, blue: 222/255).opacity(1.0)
  static let retroGreen03Basic = Color(red: 8/255, green: 152/255, blue: 172/255).opacity(1.0)
  static let retroGreen04Dark = Color(red: 5/255, green: 106/255, blue: 120/255).opacity(1.0)
  static let retroViolet01Highlight = Color(red: 245/255, green: 241/255, blue: 253/255).opacity(1.0)
  static let retroViolet02Light = Color(red: 218/255, green: 201/255, blue: 249/255).opacity(1.0)
  static let retroViolet03Basic = Color(red: 162/255, green: 121/255, blue: 241/255).opacity(1.0)
  static let retroViolet04Dark = Color(red: 113/255, green: 84/255, blue: 168/255).opacity(1.0)
  static let retroNavy01Highlight = Color(red: 237/255, green: 237/255, blue: 242/255).opacity(1.0)
  static let retroNavy02Light = Color(red: 185/255, green: 184/255, blue: 203/255).opacity(1.0)
  static let retroNavy03Basic = Color(red: 80/255, green: 77/255, blue: 125/255).opacity(1.0)
  static let retroNavy04Dark = Color(red: 55/255, green: 53/255, blue: 87/255).opacity(1.0)
}

// - MARK: HDS Colors
extension Palette {
  // Shadow Colors
  static let shadowBlack06Percent = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.06)
  static let shadowBlack10Percent = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.10)
  static let shadowBlack15Percent = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.15)
  static let shadowBlack20Percent = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.2)
  static let shadowBlack14Percent = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.14)
  static let shadowBlack12Percent = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.12)
  
  // HDS Colors
  static let transparent = Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.0)
  
  static let black100Percent = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(1.0)
  static let black90Percent = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.9)
  static let black80Percent = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.8)
  static let black70Percent = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.7)
  static let black60Percent = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.6)
  static let black50Percent = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.5)
  static let black40Percent = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.4)
  static let black30Percent = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.3)
  static let black20Percent = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.2)
  static let black10Percent = Color(red: 0/255, green: 0/255, blue: 0/255).opacity(0.1)
  
  static let white100Percent = Color(red: 255/255, green: 255/255, blue: 255/255).opacity(1.0)
  static let white90Percent = Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.9)
  static let white80Percent = Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.8)
  static let white70Percent = Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.7)
  static let white60Percent = Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.6)
  static let white50Percent = Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.5)
  static let white40Percent = Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.4)
  static let white30Percent = Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.3)
  static let white20Percent = Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.2)
  static let white10Percent = Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.1)
  
  static let gray900 = Color(red: 46/255, green: 46/255, blue: 46/255).opacity(1.0)
  static let gray800 = Color(red: 92/255, green: 92/255, blue: 92/255).opacity(1.0)
  static let gray700 = Color(red: 137/255, green: 137/255, blue: 137/255).opacity(1.0)
  static let gray600 = Color(red: 183/255, green: 183/255, blue: 183/255).opacity(1.0)
  static let gray500 = Color(red: 229/255, green: 229/255, blue: 229/255).opacity(1.0)
  static let gray400 = Color(red: 234/255, green: 234/255, blue: 234/255).opacity(1.0)
  static let gray300 = Color(red: 239/255, green: 239/255, blue: 239/255).opacity(1.0)
  static let gray200 = Color(red: 245/255, green: 245/255, blue: 245/255).opacity(1.0)
  static let gray100 = Color(red: 250/255, green: 250/255, blue: 250/255).opacity(1.0)
  
  static let primary900 = Color(red: 14/255, green: 10/255, blue: 48/255).opacity(1.0)
  static let primary800 = Color(red: 29/255, green: 19/255, blue: 97/255).opacity(1.0)
  static let primary700 = Color(red: 43/255, green: 29/255, blue: 145/255).opacity(1.0)
  static let primary600 = Color(red: 58/255, green: 38/255, blue: 194/255).opacity(1.0)
  static let primary500 = Color(red: 72/255, green: 48/255, blue: 242/255).opacity(1.0)
  static let primary400 = Color(red: 109/255, green: 89/255, blue: 245/255).opacity(1.0)
  static let primary300 = Color(red: 145/255, green: 131/255, blue: 247/255).opacity(1.0)
  static let primary200 = Color(red: 182/255, green: 172/255, blue: 250/255).opacity(1.0)
  static let primary100 = Color(red: 218/255, green: 214/255, blue: 252/255).opacity(1.0)
  
  static let sub900 = Color(red: 0/255, green: 39/255, blue: 40/255).opacity(1.0)
  static let sub800 = Color(red: 0/255, green: 77/255, blue: 79/255).opacity(1.0)
  static let sub700 = Color(red: 0/255, green: 116/255, blue: 119/255).opacity(1.0)
  static let sub600 = Color(red: 46/255, green: 46/255, blue: 46/255).opacity(1.0)
  static let sub500 = Color(red: 0/255, green: 154/255, blue: 158/255).opacity(1.0)
  static let sub400 = Color(red: 51/255, green: 205/255, blue: 209/255).opacity(1.0)
  static let sub300 = Color(red: 102/255, green: 218/255, blue: 221/255).opacity(1.0)
  static let sub200 = Color(red: 153/255, green: 230/255, blue: 232/255).opacity(1.0)
  static let sub100 = Color(red: 204/255, green: 243/255, blue: 244/255).opacity(1.0)
  
  static let feedbackRed900 = Color(red: 47/255, green: 18/255, blue: 18/255).opacity(1.0)
  static let feedbackRed800 = Color(red: 94/255, green: 37/255, blue: 37/255).opacity(1.0)
  static let feedbackRed700 = Color(red: 142/255, green: 55/255, blue: 55/255).opacity(1.0)
  static let feedbackRed600 = Color(red: 189/255, green: 74/255, blue: 74/255).opacity(1.0)
  static let feedbackRed500 = Color(red: 236/255, green: 92/255, blue: 92/255).opacity(1.0)
  static let feedbackRed400 = Color(red: 240/255, green: 125/255, blue: 125/255).opacity(1.0)
  static let feedbackRed300 = Color(red: 244/255, green: 157/255, blue: 157/255).opacity(1.0)
  static let feedbackRed200 = Color(red: 252/255, green: 231/255, blue: 231/255).opacity(1.0)
  static let feedbackRed100 = Color(red: 254/255, green: 245/255, blue: 245/255).opacity(1.0)
  
  static let feedbackYellow900 = Color(red: 51/255, green: 36/255, blue: 10/255).opacity(1.0)
  static let feedbackYellow800 = Color(red: 102/255, green: 72/255, blue: 19/255).opacity(1.0)
  static let feedbackYellow700 = Color(red: 153/255, green: 108/255, blue: 29/255).opacity(1.0)
  static let feedbackYellow600 = Color(red: 204/255, green: 144/255, blue: 38/255).opacity(1.0)
  static let feedbackYellow500 = Color(red: 255/255, green: 180/255, blue: 48/255).opacity(1.0)
  static let feedbackYellow400 = Color(red: 255/255, green: 195/255, blue: 89/255).opacity(1.0)
  static let feedbackYellow300 = Color(red: 255/255, green: 210/255, blue: 231/255).opacity(1.0)
  static let feedbackYellow200 = Color(red: 255/255, green: 244/255, blue: 224/255).opacity(1.0)
  static let feedbackYellow100 = Color(red: 255/255, green: 250/255, blue: 243/255).opacity(1.0)
  
  static let feedbackGreen900 = Color(red: 20/255, green: 43/255, blue: 18/255).opacity(1.0)
  static let feedbackGreen800 = Color(red: 41/255, green: 86/255, blue: 35/255).opacity(1.0)
  static let feedbackGreen700 = Color(red: 61/255, green: 129/255, blue: 53/255).opacity(1.0)
  static let feedbackGreen600 = Color(red: 82/255, green: 172/255, blue: 10/255).opacity(1.0)
  static let feedbackGreen500 = Color(red: 102/255, green: 215/255, blue: 88/255).opacity(1.0)
  static let feedbackGreen400 = Color(red: 133/255, green: 223/255, blue: 121/255).opacity(1.0)
  static let feedbackGreen300 = Color(red: 163/255, green: 231/255, blue: 155/255).opacity(1.0)
  static let feedbackGreen200 = Color(red: 232/255, green: 249/255, blue: 230/255).opacity(1.0)
  static let feedbackGreen100 = Color(red: 246/255, green: 253/255, blue: 245/255).opacity(1.0)
  
  static let feedbackBlue900 = Color(red: 15/255, green: 38/255, blue: 49/255).opacity(1.0)
  static let feedbackBlue800 = Color(red: 30/255, green: 77/255, blue: 98/255).opacity(1.0)
  static let feedbackBlue700 = Color(red: 44/255, green: 115/255, blue: 146/255).opacity(1.0)
  static let feedbackBlue600 = Color(red: 59/255, green: 154/255, blue: 195/255).opacity(1.0)
  static let feedbackBlue500 = Color(red: 74/255, green: 192/255, blue: 244/255).opacity(1.0)
  static let feedbackBlue400 = Color(red: 110/255, green: 205/255, blue: 246/255).opacity(1.0)
  static let feedbackBlue300 = Color(red: 146/255, green: 217/255, blue: 248/255).opacity(1.0)
  static let feedbackBlue200 = Color(red: 228/255, green: 246/255, blue: 253/255).opacity(1.0)
  static let feedbackBlue100 = Color(red: 244/255, green: 251/255, blue: 254/255).opacity(1.0)
}

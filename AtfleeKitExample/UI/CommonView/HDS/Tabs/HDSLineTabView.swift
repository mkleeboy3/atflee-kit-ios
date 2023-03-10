//
//  HDSLineTabView.swift
//  AtfleeKitExample
//
//  Created by wy.jeon on 2023/01/31.
//

import SwiftUI

struct HDSLineTabView : View {
  
  private let tabHeight: CGFloat = 48
  private let tabSelectionBarHeight: CGFloat = 2
  
  @Binding private var selectedIndex: Int
  let titles: [String]
  let selectionColor: Color
  
  init(selectedIndex: Binding<Int>, titles: [String], selectionColor: Color) {
    self._selectedIndex = selectedIndex
    self.titles = titles
    self.selectionColor = selectionColor
  }
  
  var body: some View {
    GeometryReader { geoReader in
      VStack(alignment: .leading, spacing: 0) {
        HStack(spacing: 0) {
          ForEach(titles.indices, id: \.self) { index in
            Button(action: {
              withAnimation {
                selectedIndex = index
              }
            }){
              Text(titles[index])
                .customFont(Fonts.detail4.copyWith(
                  color: selectedIndex == index ? selectionColor : Palette.gray600
                ))
            }
            .frame(width: geoReader.size.width / CGFloat(titles.count), height: tabHeight - tabSelectionBarHeight)
          }
        }
        
        Rectangle()
          .fill(Color.white)
          .frame(width: geoReader.size.width / CGFloat(titles.count))
          .padding(.bottom, tabSelectionBarHeight)
          .background(selectionColor)
          .offset(x: geoReader.size.width / CGFloat(titles.count) * CGFloat(selectedIndex))
      }
      .frame(height: tabHeight)
    }
  }
}

struct Previews_HDSLineTabView_Previews: PreviewProvider {
  @State static var selectedIndex : Int = 0
  
  static var previews: some View {
    VStack {
      HDSLineTabView(selectedIndex: $selectedIndex, titles: ["1 Tab", "2 Tab"], selectionColor: Palette.primary500)
      HDSLineTabView(selectedIndex: $selectedIndex, titles: ["1 Tab", "2 Tab", "3 Tab"], selectionColor: Palette.primary500)
      HDSLineTabView(selectedIndex: $selectedIndex, titles: ["1 Tab", "2 Tab", "3 Tab", "4 Tab", "5 Tab"], selectionColor: Palette.primary500)
    }
  }
}


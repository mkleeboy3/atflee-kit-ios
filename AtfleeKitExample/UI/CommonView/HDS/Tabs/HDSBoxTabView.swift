//
//  HDSBoxTabView.swift
//  AtfleeKitExample
//
//  Created by wy.jeon on 2023/01/31.
//

import SwiftUI

struct HDSBoxTabView : View {
  
  private let tabHeight: CGFloat = 37
  private let tabCornerRadius: CGFloat = 8
  private let paddingSize: CGFloat = 4
  
  @Binding private var selectedIndex: Int
  let titles: [String]
  
  init(selectedIndex: Binding<Int>, titles: [String]) {
    self._selectedIndex = selectedIndex
    self.titles = titles
  }
  
  var body: some View {
    GeometryReader { geoReader in
      ZStack(alignment: .leading){
        Rectangle()
          .frame(width: getItemWidth(geoReader), height: tabHeight - paddingSize * 2)
          .foregroundColor(Color.white)
          .cornerRadius(tabCornerRadius)
          .offset(x: getItemWidth(geoReader) * CGFloat(selectedIndex) + (paddingSize * CGFloat(selectedIndex + 1)))
        
        HStack(spacing: paddingSize) {
          ForEach(titles.indices, id: \.self) { index in
            Button(action: {
              withAnimation {
                selectedIndex = index
              }
            }){
              Text(titles[index])
                .customFont(Fonts.detail4.copyWith(
                  color: selectedIndex == index ? Color.black : Palette.gray600
                ))
            }
            .frame(width: getItemWidth(geoReader), height: tabHeight - paddingSize * 2)
            .cornerRadius(tabCornerRadius)
          }
        }
        .frame(width: geoReader.size.width)
        
      }
      .frame(height: tabHeight)
      .background(Palette.gray100)
      .cornerRadius(tabCornerRadius)
    }
  }
  
  private func getItemWidth(_ geoReader : GeometryProxy) -> CGFloat {
    return (geoReader.size.width - paddingSize * CGFloat(titles.count + 1)) / CGFloat(titles.count)
  }
}

struct Previews_HDSBoxTabView_Previews: PreviewProvider {
  @State static var selectedIndex : Int = 0
  
  static var previews: some View {
    VStack {
      HDSBoxTabView(selectedIndex: $selectedIndex, titles: ["1 Tab", "2 Tab"])
      HDSBoxTabView(selectedIndex: $selectedIndex, titles: ["1 Tab", "2 Tab", "3 Tab"])
      HDSBoxTabView(selectedIndex: $selectedIndex, titles: ["1 Tab", "2 Tab", "3 Tab", "4 Tab"])
    }
  }
}

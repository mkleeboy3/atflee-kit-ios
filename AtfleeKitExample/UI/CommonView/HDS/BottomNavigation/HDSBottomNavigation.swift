//
//  HDSBottomNavigation.swift
//  AtfleeKitExample
//
//  Created by Ming on 2023/01/30.
//

import SwiftUI

struct HDSBottomNavigation {
  struct TabView<Content: View>: View {
    private let tabViewHeight: CGFloat = 100
    
    @Binding var selectedId: Int
    
    let tabItems: [TabItemConfiguration]
    let content: Content
    let bottomNavigationBarColor: Color
    
    init(
      selectedId: Binding<Int>,
      tabItems: [TabItemConfiguration],
      bottomNavigationBarColor: Color = Palette.white100Percent,
      @ViewBuilder content: @escaping () -> Content
    ) {
      self._selectedId = selectedId
      self.tabItems = tabItems
      self.bottomNavigationBarColor = bottomNavigationBarColor
      self.content = content()
    }
    
    var body: some View {
      VStack(spacing: 0) {
        content
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        HStack(spacing: 0) {
          ForEach(tabItems, id: \.id) { item in
            let selected = (item.id == selectedId)
            item.buildTabItemView(selected: selected)
              .onTapGesture {
                if (!selected) {
                  selectedId = item.id
                }
              }
          }
        }
        .frame(height: tabViewHeight)
        .background(bottomNavigationBarColor)
      }
    }
  }
  
  struct TabItemConfiguration {
    let id: Int
    let labelToIconSpacing: CGFloat
    let horizontalAlignment: HorizontalAlignment
    let selectedLabel: String
    let selectedLabelFont: CustomFont
    let selectedIconAsset: String
    let selectedIconSize: CGSize
    let unselectedLabel: String?
    let unselectedLabelFont: CustomFont
    let unselectedIconAsset: String
    let unselectedIconSize: CGSize
    
    init(
      id: Int,
      labelToIconSpacing: CGFloat = 4,
      horizontalAlignment: HorizontalAlignment = .center,
      selectedLabel: String,
      selectedLabelFont: CustomFont = Fonts.detail3,
      selectedIconAsset: String,
      selectedIconSize: CGSize = CGSize(width: 24, height: 24),
      unselectedLabel: String? = nil,
      unselectedLabelFont: CustomFont = Fonts.detail3.copyWith(color: Palette.gray800),
      unselectedIconAsset: String,
      unselectedIconSize: CGSize = CGSize(width: 24, height: 24)
    ) {
      self.id = id
      self.labelToIconSpacing = labelToIconSpacing
      self.horizontalAlignment = horizontalAlignment
      self.selectedLabel = selectedLabel
      self.selectedLabelFont = selectedLabelFont
      self.selectedIconAsset = selectedIconAsset
      self.selectedIconSize = selectedIconSize
      self.unselectedLabel = unselectedLabel
      self.unselectedLabelFont = unselectedLabelFont
      self.unselectedIconAsset = unselectedIconAsset
      self.unselectedIconSize = unselectedIconSize
    }
    
    @ViewBuilder
    func buildTabItemView(selected: Bool) -> some View {
      HStack(spacing: 0) {
        Spacer()
        
        VStack(
          alignment: horizontalAlignment,
          spacing: 0
        ) {
          Spacer()
          
          Image(selected ? selectedIconAsset : unselectedIconAsset)
            .frame(
              width: selected ? selectedIconSize.width : unselectedIconSize.width,
              height: selected ? selectedIconSize.height : unselectedIconSize.height
            )
          
          Spacer().frame(height: labelToIconSpacing)
          
          Text(selected ? selectedLabel : (unselectedLabel ?? selectedLabel))
            .customFont(selected ? selectedLabelFont : unselectedLabelFont)
          
          Spacer()
        }
        
        Spacer()
      }
      .frame(maxWidth: .infinity)
    }
  }
}

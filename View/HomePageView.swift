//
//  HomePageView.swift
//  BPS_MVVM
//
//  Created by 林秀謙 on 2023/11/21.
//

import SwiftUI

struct HomePageView: View {
    @StateObject var theme = Theme.shared
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "figure.fall.circle.fill")
                    Text(Theme.shared.isZhorEn ? "Home" : "首頁")
                }
            ChartPageView()
                .tabItem {
                    Image(systemName: "figure.fall.circle.fill")
                    Text(Theme.shared.isZhorEn ? "Chart" : "圖表")
                }
            SettingPageView()
                .tabItem {
                    Image(systemName: "figure.fall.circle.fill")
                    Text(Theme.shared.isZhorEn ? "Setting" : "設定")
                }
        }
        .preferredColorScheme(theme.isDark ? .dark : .light)
    }
}

#Preview {
    HomePageView()
}

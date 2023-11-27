//
//  SettingPageView.swift
//  BPS_MVVM
//
//  Created by 林秀謙 on 2023/11/21.
//
import Foundation
import SwiftUI

struct SettingPageView: View {
    @StateObject var theme = Theme.shared
    
    var body: some View {
        NavigationView{
            Form{
                Section(
                    header: Text(theme.isZhorEn ? "Display" : "顯示")
                ) {
                    Toggle(theme.isZhorEn ? "Dark mode" : "暗黑模式", isOn: $theme.isDark)
                    Toggle(theme.isZhorEn ? "Language ch/cn" : "語言 中文/英文", isOn: $theme.isZhorEn)
                }
            }
            .navigationTitle(theme.isZhorEn ? "Setting" : "設定")
        }
    }
}


#Preview {
    SettingPageView()
}

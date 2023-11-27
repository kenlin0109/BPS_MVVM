//
//  ThemeClass.swift
//  BPS_MVVM
//
//  Created by 林秀謙 on 2023/11/14.
//

import Foundation

class Theme:ObservableObject{
    static let shared = Theme()
    
    @Published var isDark: Bool {
        didSet {
            UserDefaults.standard.set(isDark, forKey: "isDark")
        }
    }
    @Published var isZhorEn: Bool {
        didSet {
            UserDefaults.standard.set(isZhorEn, forKey: "isZhorEn")
        }
    }
    init() {
        self.isDark = (UserDefaults.standard.bool(forKey: "isDark"))
        self.isZhorEn = (UserDefaults.standard.bool(forKey: "isZhorEn"))
    }
}

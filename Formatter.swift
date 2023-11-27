//
//  Formatter.swift
//  BPS_MVVM
//
//  Created by 林秀謙 on 2023/11/14.
//

import Foundation

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    return formatter
}()

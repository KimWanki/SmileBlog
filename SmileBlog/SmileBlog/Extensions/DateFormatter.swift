//
//  DateFormatter.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/03.
//

import Foundation

extension DateFormatter {
    static func getCurrent() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.string(from: Date())
    }
}

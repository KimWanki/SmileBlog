//
//  HttpMethod.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/05.
//

import Foundation

enum HttpMethod: String {
    case get
    case post
    case put
    case patch
    case delete
    
    var description: String {
        rawValue
    }
}

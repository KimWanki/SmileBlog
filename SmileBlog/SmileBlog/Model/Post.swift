//
//  Post.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/10/30.
//

import Foundation

struct Post: Codable {
    let number: Int?
    let title: String
    let content: String
    let date: String
}

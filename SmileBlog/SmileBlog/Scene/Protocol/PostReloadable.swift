//
//  PostReloadable.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/04.
//

import Foundation


protocol PostReloadable: NSObject {
    func reloadTableView(_ newPost: [Post])
    func updatePost(_ newPost: Post)
}

extension PostReloadable {
    func reloadTableView(_ newPost: [Post]) { }
    func updatePost(_ newPost: Post) { }
}

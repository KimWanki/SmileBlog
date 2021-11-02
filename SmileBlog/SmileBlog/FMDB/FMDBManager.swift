//
//  FMDBManager.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/02.
//

import Foundation
import FMDB

final class FMDBManager {
    private let DATABASE_NAME = "blog.sqlite"
    
    static let shared = FMDBManager()

    private init() {
        self.fmdb.open()
    }
    
    deinit {
        self.fmdb.close()
    }

    lazy var fmdb: FMDatabase! = {
        let fileManager = FileManager.default
        
        let docPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        guard let dbPath = docPath?.appendingPathComponent(DATABASE_NAME).path
        else { return nil }
        
        if fileManager.fileExists(atPath: dbPath) == false {
            let dbName = DATABASE_NAME.split(separator: ".").map { String($0) }
            let dbSource = Bundle.main.path(forResource: dbName[0], ofType: dbName[1])
            
            dbSource.flatMap {
                try? fileManager.copyItem(atPath: $0, toPath: dbPath)
            }
        }
        let db = FMDatabase(path: dbPath)
        
        return db
    }()
    
    func copyDatabaseIfNeeds() {
        self.fmdb.open()
        let fileMgr = FileManager.default
        guard let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return }
        
        let dbPath = docPathURL.appendingPathComponent("blog.sqlite").path
        
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "blog", ofType: "sqlite")
            
            dbSource.flatMap { try? fileMgr.copyItem(atPath: $0, toPath: dbPath) }
        }
    }
    
    func getPosts() -> [Post] {
        var postList = [Post]()
        do {
            let sql = """
            SELECT *
            FROM post
            ORDER BY post_date DESC
            """
            
            let result = try fmdb.executeQuery(sql, values: nil)
            
            while result.next() {
                let postNumber = result.int(forColumn: "post_num")
                let postTitle = result.string(forColumn: "post_title")
                let postContent = result.string(forColumn: "post_content")
                let postDate = result.string(forColumn: "post_date")
                
                let post = Post(number: Int(postNumber),
                                title: postTitle!,
                                content: postContent!,
                                date: postDate!)
                postList.append(post)
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return postList
    }
}

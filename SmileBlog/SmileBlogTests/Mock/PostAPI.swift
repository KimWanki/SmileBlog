//
//  PostAPI.swift
//  SmileBlogTests
//
//  Created by WANKI KIM on 2021/11/05.
//

import Foundation
@testable import SmileBlog

struct BlogAPI {
    static var url = URL(string: "https://smilegate.com/blog")!
        
        var sampleData: Data {
            Data(
                """
                {
                    "type": "success",
                        "value": {
                        "number": 1,
                        "title": "첫 포스트의 제목입니다",
                        "content": "첫 포스트의 내용입니다",
                        "date": "2021.11.05"
                    }
                }
                """.utf8
            )
        }
}

struct PostResponse: Decodable {
    let tyle: String
    let value: Post
}

class PostAPIProvider {
    let session: URLSession
    
    init(_ session: URLSession) {
        self.session = session
    }
    
    func fetchRandomPost(completion: @escaping (Result<Post, NetworkError>) -> Void) {
        let request = URLRequest(url: BlogAPI.url)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode)
            else {
                completion(.failure(.invalidResponse))
            }
            if let data = data {
                let response = try? JSONDecoder().decode(PostResponse.self, from: data)
                completion(.success(response!.value))
                return
            }
            completion(.failure(.invalidResponse))
        }
        task.resume()
    }
}

//
//  NetworkError.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/05.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case dataIsNil
    case unknown(description: String)
    case clientSide(description: String)
    case serverSide(description: String)
}


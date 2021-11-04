//
//  NetworkManager.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/05.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

class NetworkManager {
    private let session: URLSessionProtocol
    
    init(_ session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<Model: URLSessionProtocol & Codable>(url: URL,
                                                  completion: @escaping (Result<Model, Error>) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                let unknownError = NetworkError.unknown(
                    description: error.localizedDescription
                )
                completion(.failure(unknownError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            switch response.statusCode {
            case 200..<300:
                self.handleSuccessStatusCode(data: data, completion: completion)
            default:
                self.handleFailureStatusCode(response: response, completion: completion)
            }
        }.resume()
    }
    
    private func handleSuccessStatusCode<Model: URLSessionProtocol & Codable>(
        data: Data?,
        completion: @escaping (Result<Model, Error>) -> Void
    ) {
        guard let data = data else {
            completion(.failure(NetworkError.dataIsNil))
            return
        }
        
        do {
            let model: Model = try JSONDecoder().decode(Model.self, from: data)
            completion(.success(model))
        } catch {
            completion(.failure(error))
        }
    }
    
    private func handleFailureStatusCode<Model>(
        response: HTTPURLResponse,
        completion: @escaping (Result<Model, Error>) -> Void
    ) {
        switch response.statusCode {
        case 400..<500:
            completion(.failure(NetworkError.clientSide(description: response.debugDescription)))
        case 500..<600:
            completion(.failure(NetworkError.serverSide(description: response.debugDescription)))
        default:
            completion(.failure(NetworkError.unknown(description: response.debugDescription)))
        }
    }
}

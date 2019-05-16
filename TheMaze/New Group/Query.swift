//
//  Query.swift
//  TheMaze
//
//  Created by Hugo Medina on 16/05/2019.
//  Copyright © 2019 Razeware. All rights reserved.
//

import Foundation

class Network {
    typealias NetworkCompletion<T> = (T?, NetworkError?)->Void
    
    static func getContent<T: Codable>(
        urlRequest: URLRequest,
        decodable: T.Type,
        configuration: URLSessionConfiguration = URLSessionConfiguration.default,
        delegate: URLSessionDelegate? = nil,
        delegateQueue: OperationQueue? = nil,
        completion: @escaping NetworkCompletion<T>
        ) {
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: urlRequest) {
            data, response, error in
            
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, .generic("No response received"))
                return
            }
            
            guard response.statusCode < 300 else {
                completion(nil, .http(response.statusCode))
                return
            }
            
            if let d = try? JSONDecoder().decode(decodable, from: data) {
                completion(d, nil)
            } else {
                completion(nil, .jsonParsingFail)
            }
        }
        
        task.resume()
    }
    
    static func postContent<T: Codable>(
        urlRequest: URLRequest,
        data: T,
        decodable: T.Type,
        configuration: URLSessionConfiguration = URLSessionConfiguration.default,
        delegate: URLSessionDelegate? = nil,
        delegateQueue: OperationQueue? = nil,
        completion: @escaping NetworkCompletion<T>
        ) {
        let session = URLSession(configuration: configuration)
        
        var request = urlRequest
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Application/json", forHTTPHeaderField: "Accept")
        guard let json = try? JSONEncoder().encode(data) else {
            completion(nil, .jsonParsingFail)
            return
        }
        request.httpBody = json
        
        let task = session.dataTask(with: request) {
            data, response, error in
            
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, .generic("No response received"))
                return
            }
            
            guard response.statusCode < 300 else {
                completion(nil, .http(response.statusCode))
                return
            }
            
            if let d = try? JSONDecoder().decode(decodable, from: data) {
                completion(d, nil)
            } else {
                completion(nil, .jsonParsingFail)
            }
        }
        task.resume()
    }
}

extension Network {
    enum NetworkError : Error {
        case noData
        case jsonParsingFail
        case http(Int)
        case generic(String)
        case urlFormating(String)
        
        var localizedDescription: String {
            switch self {
            case .noData:
                return NSLocalizedString("No data was returned by query", comment: "No Data")
            case .jsonParsingFail:
                return NSLocalizedString("Couldn't parse JSON with Codable provided", comment: "JSON Parsing Error")
            case .http(let code):
                return NSLocalizedString("Invalid HTTP response with code : \(code)", comment: "HTTP error")
            case .generic(let message):
                return NSLocalizedString(message, comment: "Something went wrong")
            case .urlFormating(let url):
                return NSLocalizedString("\(url) is not a valid url", comment: "URL Formatting")
            }
        }
    }
}

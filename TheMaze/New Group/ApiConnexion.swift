//
//  ApiConnexion.swift
//  TheMaze
//
//  Created by Hugo Medina on 16/05/2019.
//  Copyright © 2019 Razeware. All rights reserved.
//

import Foundation

class APIConnexion {
    let baseUrl: String
    
    public init(apiUrl: String? = nil) {
        baseUrl = apiUrl ?? "http://10.93.182.93"
    }
    
    
    public func getGroup(_ name: String, completion: @escaping (Group?, Network.NetworkError?) -> Void) {
        let uri = "/group/\(name)"
        
        guard let url = URL(string: baseUrl + uri) else {
            completion(nil, .urlFormating("\(baseUrl + uri) is not a valid url"))
            return
        }
        
        Network.getContent(urlRequest: URLRequest(url: url), decodable: Group.self) {
            group, error in
            
            completion(group, error)
        }
    }
    
    public func update(group: Group, completion: @escaping (Group? , Network.NetworkError?) -> Void) {
        
    }
}

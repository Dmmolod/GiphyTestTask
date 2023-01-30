//
//  Request.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 28.01.2023.
//

import Foundation

struct Request {
    let version: String
    let method: String
    let path: String
    let query: [String: String]
}

extension Request {
    
    static func get(
        _ path: String,
        version: String = "v1",
        query: [String: String] = [:]
    ) -> Request{
        Request(
            version: version,
            method: "GET",
            path: path,
            query: query
        )
    }
    
}

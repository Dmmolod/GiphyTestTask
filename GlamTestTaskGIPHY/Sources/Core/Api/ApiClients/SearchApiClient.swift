//
//  SearchApiClient.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 29.01.2023.
//

import Foundation

protocol SearchApiClientProtocol {
    func fetch(
        with searchText: String,
        offset: Int32,
        limit: Int32,
        completion: @escaping (Result<GiphyObjectsResponse, Error>) -> ()
    )
}

struct SearchApiClient {
    
    private let api: ApiClient
    
    init(api: ApiClient = ApiClient()) {
        self.api = api
    }
}

extension SearchApiClient: SearchApiClientProtocol {
    
    func fetch(
        with searchText: String,
        offset: Int32,
        limit: Int32,
        completion: @escaping (Result<GiphyObjectsResponse, Error>) -> ()
    ) {
        let query = [
            "q": searchText,
            "limit" : "\(limit)",
            "offset" : "\(offset)"
        ]
        
        let request: Request = .get("/gifs/search", query: query)
        
        api.request(request, response: completion)
    }
}

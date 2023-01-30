//
//  TrandingsApiClient.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 28.01.2023.
//

import Foundation

protocol TrandingGifsApiClientProtocol {
    func getTrandingGifs(
        limit: Int32,
        offset: Int32,
        completion: @escaping (Result<GiphyObjectsResponse, Error>) -> ()
    )
}

struct TrandingGifsApiClient {
    
    private let api: ApiClient
    
    init(api: ApiClient = ApiClient()) {
        self.api = api
    }

}

extension TrandingGifsApiClient: TrandingGifsApiClientProtocol {
    
    func getTrandingGifs(
        limit: Int32,
        offset: Int32,
        completion: @escaping (Result<GiphyObjectsResponse, Error>) -> ()
    ) {
        let request: Request = .get(
            "/gifs/trending",
            query: [
                "limit": "\(limit)",
                "offset": "\(offset)"
            ]
        )
        
        api.request(request, response: completion)
    }
}

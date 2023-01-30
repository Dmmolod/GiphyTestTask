//
//  CategoriesApiClient.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 29.01.2023.
//

import Foundation

protocol CategoriesApiClientProtocol {
    func fetchCategories(completion: @escaping (Result<GiphyCategoriesResponse, Error>) -> ())
}

struct CategoriesApiClient {
    
    private let api: ApiClient
    
    init(api: ApiClient = ApiClient()) {
        self.api = api
    }
}

extension CategoriesApiClient: CategoriesApiClientProtocol {
    
    func fetchCategories(completion: @escaping (Result<GiphyCategoriesResponse, Error>) -> ()) {
        let request: Request = .get("/gifs/categories")
        
        api.request(request, response: completion)
    }
    
}

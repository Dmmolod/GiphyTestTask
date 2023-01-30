//
//  MainScreenApiService.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 29.01.2023.
//

import Foundation

final class MainScreenApiService {
    
    //MARK: - Public Properties
    var trandingResponse: ((Result<GiphyObjectsResponse, Error>) -> ())?
    var categoriesResponse: ((Result<GiphyCategoriesResponse, Error>) -> ())?
    var searchResponse: ((String, Result<GiphyObjectsResponse, Error>) -> ())?
    
    //MARK: - Private Properties
    private let trandingApiClient: TrandingGifsApiClientProtocol
    private let categoriesApiClient: CategoriesApiClientProtocol
    private let searchApiClient: SearchApiClientProtocol
    
    //MARK: - Initializers
    init(
        trandingApiClient: TrandingGifsApiClientProtocol,
        categoriesApiClient: CategoriesApiClientProtocol,
        searchApiClient: SearchApiClientProtocol
    ) {
        self.trandingApiClient = trandingApiClient
        self.categoriesApiClient = categoriesApiClient
        self.searchApiClient = searchApiClient
    }
    
    //MARK: - API
    func fetchTranding(limit: Int32, offset: Int32) {
        guard let completion = trandingResponse else { return }
        trandingApiClient.getTrandingGifs(
            limit: limit,
            offset: offset,
            completion: completion
        )
    }
    
    func fetchCategories() {
        guard let completion = categoriesResponse else { return }
        categoriesApiClient.fetchCategories(completion: completion)
    }
    
    func search(_ searchText: String, limit: Int32, offset: Int32) {
        guard let completion = searchResponse else { return }
        searchApiClient.fetch(
            with: searchText,
            offset: offset,
            limit: limit,
            completion: { result in
                completion(searchText, result)
            }
        )
    }
}

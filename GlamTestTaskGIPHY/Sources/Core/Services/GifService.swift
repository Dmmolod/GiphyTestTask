//
//  GifService.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 29.01.2023.
//

import Foundation

protocol GifServiceProtocol {
    func fetch(with gifLink: String, completion: @escaping (Data?) -> ())
}

final class GifService: GifServiceProtocol {
    
    private let localService: LocalService
    private let gifApiClient: GifApiClient
    
    init(
        localService: LocalService = LocalService(),
        gifApiClient: GifApiClient = GifApiClient()
    ) {
        self.localService = localService
        self.gifApiClient = gifApiClient
    }
    
    func fetch(with gifLink: String, completion: @escaping (Data?) -> ()) {
        if let gifData = fetchFromLocal(with: gifLink) { completion(gifData) }
        else { fetchFromApi(with: gifLink, completion: completion) }
    }
    
}

extension GifService {
    
    private func fetchFromLocal(with link: String) -> Data? {
        guard let gifPath = GifService.makePath(with: link) else { return nil }
        return localService.read(path: gifPath)
    }
    
    private func fetchFromApi(with link: String, completion: @escaping (Data?) -> ()) {
        gifApiClient.fetchGif(with: link) { [localService] gifData in
            
            completion(gifData)
            
            guard let gifData,
                  let gifPath = GifService.makePath(with: link)
            else { return }
            
            localService.write(gifData, with: gifPath)
        }
    }
    
}

extension GifService {
    
    private static func makePath(with link: String) -> String? {
        guard let cacheDirectoryUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first,
              let urlPathComponents = URL(string: link)?.pathComponents,
              let urlIdPath = urlPathComponents[safe: 2],
              let urlTypePath = urlPathComponents[safe: 3]
        else { return nil }
        
        let fileName = urlIdPath + urlTypePath
        
        return cacheDirectoryUrl.appending(path: fileName).path()
    }
    
}

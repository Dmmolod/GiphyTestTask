//
//  GifApiClient.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 29.01.2023.
//

import Foundation

struct GifApiClient {
    
    func fetchGif(with link: String, completion: @escaping (Data?) -> ()) {
        guard let url = URL(string: link) else { return }
        
        URLSession.shared.dataTask(
            with: url,
            completionHandler: { data, response, _ in
                guard response?.mimeType?.contains("gif") == true else { return }
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        ).resume()
    }
}

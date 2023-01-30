//
//  GiphyApi.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 28.01.2023.
//

import Foundation

struct ApiClient {
    
    private let apiKey = "5WyCA3cahR3B9rbZaVfDZkv15oSp389P"
    let host: String
    
    init(host: String = "api.giphy.com") {
        self.host = host
    }
}

extension ApiClient {
    
    func request<Response: Decodable>(
        _ request: Request,
        response: @escaping (Result<Response, Error>) -> ()
    ) {
        makeURLRequest(for: request)
            .onSuccess { send($0, response) }
            .onFailure { response(.failure($0)) }
    }
    
    func send<T: Decodable>(
        _ request: URLRequest,
        _ completion: @escaping (Result<T, Error>) -> ()
    ) {
        URLSession.shared.dataTask(
            with: request,
            completionHandler: { data, _, error in
                if let error { return completion(.failure(error)) }
                guard let data
                else { return completion(.failure(NSError(domain: "", code: 3))) }
                guard let response = try? JSONDecoder().decode(T.self, from: data)
                else { return completion(.failure(NSError(domain: "", code: 4))) }
                
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            }
        ).resume()
    }
    
    func makeURLRequest(for request: Request) -> Result<URLRequest, Error> {
        makeURL(version: request.version, path: request.path, query: request.query).flatMap {
            makeRequest(url: $0, method: request.method)
        }
    }
    
    func makeURL(version: String, path: String, query: [String: String]) -> Result<URL, Error> {
        var query = query
        query.updateValue(apiKey, forKey: "api_key")
        
        var pathWithVersion = ""
        
        if path.starts(with: "/") {
            pathWithVersion = "/\(version)\(path)"
        } else { pathWithVersion = "/\(version)/\(path)" }
        
        guard let url = URL(string: pathWithVersion) else { return .failure(NSError(domain: "", code: 0)) }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.scheme = "https"
        components?.host = host
        components?.queryItems = query.map(URLQueryItem.init)
        
        guard let url = components?.url else { return .failure(NSError(domain: "", code: 1)) }
        
        return .success(url)
    }
    
    func makeRequest(url: URL, method: String) -> Result<URLRequest, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        return .success(request)
    }
}

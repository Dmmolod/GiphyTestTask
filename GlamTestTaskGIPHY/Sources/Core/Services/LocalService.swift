//
//  LocalService.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 29.01.2023.
//

import Foundation

struct LocalService {
    
    func read(path: String) -> Data? {
        FileManager.default.contents(atPath: path)
    }
    
    func write(_ data: Data, with path: String) {
        if FileManager.default.fileExists(atPath: path) { return }
        FileManager.default.createFile(atPath: path, contents: data)
    }
    
    func remove(url: URL) {
        try? FileManager.default.removeItem(at: url)
    }
    
}

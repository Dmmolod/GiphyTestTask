//
//  Result + Extension.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 28.01.2023.
//

import Foundation

extension Result {
    
    @discardableResult
    func onSuccess(_ handler: (Success) -> ()) -> Self {
        if case let .success(value) = self {
            handler(value)
        }
        return self
    }
    
    @discardableResult
    func onFailure(_ handler: (Failure) -> ()) -> Self {
        if case let .failure(value) = self {
            handler(value)
        }
        return self
    }
}

//
//  GiphyCategoriesResponse.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 29.01.2023.
//

import Foundation

struct GiphyCategoriesResponse: Decodable {
    let data: [GiphyCategoriesModel]
}

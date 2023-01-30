//
//  MainScreenFactory.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 28.01.2023.
//

import UIKit

struct MainScreenFactory {
    static func makeMainScren() -> UIViewController {
        let apiService = MainScreenApiService(
            trandingApiClient: TrandingGifsApiClient(),
            categoriesApiClient: CategoriesApiClient(),
            searchApiClient: SearchApiClient()
        )
        
        let gifService = GifService()
        
        let viewController = MainScreenViewController()
        
        let presenter = MainScreenPresenterImpl(
            view: viewController,
            apiService: apiService,
            gifService: gifService
        )
        
        viewController.presenter = presenter
        return viewController
    }
}

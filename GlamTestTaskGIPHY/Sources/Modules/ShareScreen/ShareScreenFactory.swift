//
//  ShareScreenFactory.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 30.01.2023.
//

import UIKit

struct ShareScreenFactory {
    static func makeShareScreen(with gifModel: GifModel) -> UIViewController {
        let viewController = ShareScreenViewController()
        
        let gifService = GifService()
        
        let presenter = ShareScreenPresenter(
            shareView: viewController,
            gifService: gifService,
            gifModel: gifModel
        )
        
        viewController.presenter = presenter
        
        return viewController
    }
}

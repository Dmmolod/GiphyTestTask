//
//  MainScreenViewController.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 28.01.2023.
//

import UIKit

protocol MainScreenViewProtocol: AnyObject {
    func updateCollection(with model: [GifModel])
    func updateHeaderSections(with model: [String])
    func presentShareScreen(with gifModel: GifModel)
}

final class MainScreenViewController: UIViewController {
    
    //MARK: - Public Properties
    var presenter: MainScreenPresenterProtocol?
    
    //MARK: - Private Properties
    private let mainScreenView = MainScreenView()
    
    //MARK: - Override Methods
    override func loadView() {
        view = mainScreenView
        mainScreenView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFetchGifAction()
        presenter?.viewDidLoad()
    }
    
    private func setFetchGifAction() {
        guard let action = presenter?.fetchGif else { return }
        mainScreenView.setFetchGifActionInCollection(action)
    }
}

//MARK: - MainView Protocol
extension MainScreenViewController: MainScreenViewProtocol {
    func updateCollection(with model: [GifModel]) {
        mainScreenView.reloadCollection(with: model)
    }
    
    func updateHeaderSections(with model: [String]) {
        mainScreenView.updateCollectionHeaderSections(with: model)
    }
    
    func presentShareScreen(with gifModel: GifModel) {
        let shareViewController = ShareScreenFactory.makeShareScreen(with: gifModel)
        shareViewController.modalPresentationStyle = .fullScreen
        
        present(shareViewController, animated: true)
    }
}

//MARK: - MainView Delegate
extension MainScreenViewController: MainScreenViewDelegate {
    func didSelectItem(at indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath)
    }
    
    func didScrollToEnd() {
        presenter?.didScrollToEnd()
    }
    
    func didSelectSection(_ type: MainSectionType) {
        presenter?.didSelectSection(type)
    }
}

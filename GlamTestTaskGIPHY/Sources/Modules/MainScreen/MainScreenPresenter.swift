//
//  MainScreenPresenter.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 28.01.2023.
//

import Foundation

protocol MainScreenPresenterProtocol {
    func fetchGif(_ link: String, completion: @escaping (Data?) -> ())
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
    func didScrollToEnd()
    func didSelectSection(_ type: MainSectionType)
}

final class MainScreenPresenterImpl {
    
    //MARK: - View
    unowned let mainScreenView: MainScreenViewProtocol
    
    //MARK: - Services
    private let apiService: MainScreenApiService
    private let gifService: GifServiceProtocol
    
    //MARK: - Model
    private var models: [MainSectionType: MainPresenterModel] = [:]
    
    //MARK: - Private Properties
    private var isPaginationEnable = false
    private var currentCollectionType: MainSectionType = .trandings
    
    //MARK: - Initializers
    init(
        view: MainScreenViewProtocol,
        apiService: MainScreenApiService,
        gifService: GifServiceProtocol
    ) {
        self.mainScreenView = view
        self.apiService = apiService
        self.gifService = gifService
        
        subscribeForResponses()
    }
    
    //MARK: - Subscribe
    private func subscribeForResponses() {
        apiService.trandingResponse = { [weak self] result in
            result.onSuccess { gifObjects in
                let newTrandingItems: [GifModel] = gifObjects.data.map { .converted($0) }
                let newOffset = gifObjects.pagination.offset + gifObjects.pagination.count
                
                self?.updateModels(
                    for: .trandings,
                    newItems: newTrandingItems,
                    newOffset: newOffset
                )
                
                if self?.currentCollectionType == .trandings {
                    self?.updateCollectionView()
                }
            }
            self?.isPaginationEnable = true
        }
        
        apiService.categoriesResponse = { [weak self] result in
            result.onSuccess { categories in
                self?.updateSectionsHeader(with: categories.data)
            }
        }
        
        apiService.searchResponse = { [weak self] searchText, result in
            result.onSuccess { gifObjects in
                let newItems: [GifModel] = gifObjects.data.map { .converted($0) }
                let newOffset = gifObjects.pagination.offset + gifObjects.pagination.count
                
                self?.updateModels(
                    for: .category(name: searchText),
                    newItems: newItems,
                    newOffset: newOffset
                )
                
                if self?.currentCollectionType == .category(name: searchText) {
                    self?.updateCollectionView()
                }
            }
            
            self?.isPaginationEnable = true
        }
    }
    
}

//MARK: - MainScreenPresenter Protocol Methods
extension MainScreenPresenterImpl: MainScreenPresenterProtocol {
    
    func fetchGif(_ link: String, completion: @escaping (Data?) -> ()) {
        gifService.fetch(with: link, completion: completion)
    }
    
    func viewDidLoad() {
        apiService.fetchCategories()
        apiService.fetchTranding(
            limit: 30,
            offset: 0
        )
    }
    
    func didSelectSection(_ type: MainSectionType) {
        if currentCollectionType == type { return }
        currentCollectionType = type
        
        if let items = models[type]?.items {
            mainScreenView.updateCollection(with: items)
        } else {
            fetchNewContent()
        }
        
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        guard let item = models[currentCollectionType]?.items[safe: indexPath.item] else { return }
        mainScreenView.presentShareScreen(with: item)
    }
    
    func didScrollToEnd() {
        guard isPaginationEnable else { return }
        isPaginationEnable = false
        
        fetchNewContent()
    }
}

//MARK: - Supporting Private Methods
extension MainScreenPresenterImpl {
   
    private func updateSectionsHeader(with model: [GiphyCategoriesModel]) {
        let model = model.map(\.name)
        mainScreenView.updateHeaderSections(with: model)
    }
    
    private func updateCollectionView() {
        guard let items = models[currentCollectionType]?.items else { return }
        mainScreenView.updateCollection(with: items)
    }
    
    private func updateModels(for type: MainSectionType, newItems: [GifModel], newOffset: Int32){
        var updatedModel = MainPresenterModel(
            items: [],
            offset: newOffset
        )
        
        if let currentItems = models[type]?.items {
            updatedModel.items.append(contentsOf: currentItems)
        }
        
        updatedModel.items.append(contentsOf: newItems)
        
        models.updateValue(
            updatedModel,
            forKey: type
        )
    }
    
    private func fetchNewContent() {
        let currentOffset = models[currentCollectionType]?.offset
        
        switch currentCollectionType {
        case .trandings:
            apiService.fetchTranding(
                limit: 30,
                offset: currentOffset ?? 0
            )
        case let .category(categoryName):
            apiService.search(
                categoryName,
                limit: 30,
                offset: currentOffset ?? 0
            )
        }
    }
}

//MARK: - Converted GIPHY Objecy Model Extension
extension GifModel {
    static func converted(_ model: GiphyObjectModel) -> GifModel {
        GifModel(
            mediumLink: model.images.medium.url,
            originalLink: model.images.original.url,
            giphyLink: model.url,
            height: CGFloat(Int(model.images.small.height) ?? 0)
        )
    }
}

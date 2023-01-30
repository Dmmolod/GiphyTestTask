//
//  ShareScreenPresenter.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 29.01.2023.
//

import UIKit
import Photos

protocol ShareScreenPresenterProtocol: AnyObject {
    func loadView()
    func didTapClose()
    func didTapCancel()
    func didTapShare()
    func didTapCopyLink()
    func didTapSaveToGallery()
    func didSelectShareItem(_ type: ShareType)
}

final class ShareScreenPresenter {
    
    //MARK: - Private Properties
    private unowned let shareView: ShareScreenViewProtocol

    private let gifService: GifService
    private let gifModel: GifModel
    private var gifData: Data?
    
    //MARK: - Initializers
    init(
        shareView: ShareScreenViewProtocol,
        gifService: GifService,
        gifModel: GifModel
    ) {
        self.shareView = shareView
        self.gifService = gifService
        self.gifModel = gifModel
    }
    
}

//MARK: - ShareScreen Presenter Protocol Methods
extension ShareScreenPresenter: ShareScreenPresenterProtocol {
    
    func loadView() {
        gifService.fetch(
            with: gifModel.originalLink,
            completion: { [weak self] gifData in
                guard let gifData else { return }
                
                self?.gifData = gifData
                self?.shareView.setGif(gifData)
            }
        )
    }
    
    func didTapClose() {
        shareView.dismiss()
    }
    
    func didTapCancel() {
        shareView.dismiss()
    }
    
    func didTapShare() {
        guard let gifData else { return }
        shareView.presentShare(with: gifData)
    }
    
    func didTapCopyLink() {
        UIPasteboard.general.string = gifModel.giphyLink
        shareView.presentMessage(with: "Successfully copy the link!")
    }
    
    func didTapSaveToGallery() {
        guard let gifData else { return }
        saveGifToGallery(gifData)
    }
    
    func didSelectShareItem(_ type: ShareType) {
        guard let gifData else { return }
        share(gifData, with: type)
    }
    
}

//MARK: - Supportin Private Methods
extension ShareScreenPresenter {
    
    private func saveGifToGallery(_ data: Data) {
        DispatchQueue.global().async {
            PHPhotoLibrary.shared().performChanges {
                let request = PHAssetCreationRequest.forAsset()
                request.addResource(with: .photo, data: data, options: nil)
            } completionHandler: { isSuccess, error in
                DispatchQueue.main.async {
                    if isSuccess { self.shareView.presentMessage(with: "Successfully saved in Gallery!") }
                    else { self.shareView.presentMessage(with: error?.localizedDescription ?? "Unknown error") }
                }
            }
        }
    }
    
    private func share(_ data: Data, with type: ShareType) {
        switch type {
        case .iMessage:
            shareView.shareToIMessage(data)
        case .whatsapp:
            shareView.share(data)
        case .facebook:
            shareView.share(data)
        case .twitter:
            shareView.share(data)
        case .instagram:
            shareView.share(data)
        case .snapChat:
            shareView.share(data)
        }
    }
}

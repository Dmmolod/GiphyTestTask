//
//  ShareScreenViewController.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 29.01.2023.
//

import UIKit
import MessageUI

protocol ShareScreenViewProtocol: AnyObject {
    func setGif(_ data: Data)
    func presentMessage(with text: String)
    func presentShare(with gifData: Data)
    func share(_ data: Data)
    func shareToIMessage(_ data: Data)
    func dismiss()
}

final class ShareScreenViewController: UIViewController, ShowToastLogic {
    
    //MARK: - Public Properties
    var presenter: ShareScreenPresenterProtocol?
    
    //MARK: - Private Properties
    private let shareView = ShareScreenView()

    //MARK: - Override Methods
    override func loadView() {
        view = shareView
        shareView.delegate = self
        presenter?.loadView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        shareView.disappearGif()
    }
}

//MARK: - ShareView Protocol Methods
extension ShareScreenViewController: ShareScreenViewProtocol {
    
    func dismiss() {
        dismiss(animated: true)
    }
    
    func setGif(_ data: Data) {
        shareView.setupGif(data)
    }
    
    func presentMessage(with text: String) {
        showToast(with: text)
    }
    
    func presentShare(with gifData: Data) {
        let activityController = UIActivityViewController(
            activityItems: [gifData],
            applicationActivities: nil
        )
        activityController.popoverPresentationController?.sourceView = view
        
        DispatchQueue.main.async {
            self.present(activityController, animated: true)
        }
    }
    
    func share(_ data: Data) {
        presentShare(with: data)
    }
    
    func shareToIMessage(_ data: Data) {
        if MFMessageComposeViewController.canSendText() {
            let messageVC = MFMessageComposeViewController()
            messageVC.messageComposeDelegate = self
            messageVC.addAttachmentData(data, typeIdentifier: "public.data", filename: "giphy.gif")
            self.present(messageVC, animated: true, completion: nil)
        }
        else {
            showToast(with: "You haven't installed Messages.app :(")
        }
    }
}

//MARK: - ShareView Delegate Methods
extension ShareScreenViewController: ShareScreenViewDelegate {
    
    func didTapShare() {
        presenter?.didTapShare()
    }
    
    func didTapClose() {
        presenter?.didTapClose()
    }
    
    func didSelectShare(_ type: ShareType) {
        presenter?.didSelectShareItem(type)
    }
    
    func didTapCopyLink() {
        presenter?.didTapCopyLink()
    }
    
    func didTapCancel() {
        presenter?.didTapCancel()
    }
    
    func didTapSave() {
        presenter?.didTapSaveToGallery()
    }
    
}

//MARK: - ShareView MFMessage Delegate Methods
extension ShareScreenViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true)
        showToast(with: "Successfully send!")
    }
}

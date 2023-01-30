//
//  ShowToastMessage.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 30.01.2023.
//

import UIKit

protocol ShowToastLogic {
    func showToast(with message: String)
}

extension ShowToastLogic {
    func showToast(with message: String) {
        
        guard let window = UIApplication.shared.windows.first else { return }
        
        let toastView: UIView = {
            let toastView = ToastMessageView(message: message)
            toastView.alpha = 0
            return toastView
        }()
        
        window.addSubview(toastView) {
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(window).offset(20)
            $0.trailing.lessThanOrEqualTo(window).inset(20)
            $0.bottom.equalToSuperview().inset(48)
        }
        window.bringSubviewToFront(toastView)
        
        UIView.animate(withDuration: 0.3) {
            toastView.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.3) {
                toastView.alpha = 0
            } completion: { _ in
                toastView.snp.removeConstraints()
                toastView.removeFromSuperview()
            }
        }
    }
}

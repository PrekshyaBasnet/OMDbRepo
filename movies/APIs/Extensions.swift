//
//  Extensions.swift
//  movies
//
//  Created by Prekshya Admin on 19/7/19.
//  Copyright © 2019 Prekshya Admin. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(withTitle title:String, message msg: String? = nil, cancelTitle cancelTitleString: String = "Okay",cancelButtonAction: @escaping ()->() = {}) {
        let alertView = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alertView.addAction(UIAlertAction(title: cancelTitleString, style: .cancel, handler: { (_) in
            cancelButtonAction()
        }))
        self.present(alertView, animated: true, completion: nil)
    }
    
    func pushVC(vc: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

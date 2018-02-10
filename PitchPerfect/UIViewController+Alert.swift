//
//  UIViewController+Alert.swift
//  PitchPerfect
//
//  Created by Abdalla Tawfik on 1/31/18.
//  Copyright © 2018 AT Apps. All rights reserved.
//

import UIKit

// MARK: - UIViewController (UIAlertController)

extension UIViewController {
    func showAlert(_ title: String = "", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alerts.DismissAlert, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


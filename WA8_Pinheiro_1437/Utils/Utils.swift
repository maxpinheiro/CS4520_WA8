//
//  Utils.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/6/23.
//

import Foundation
import UIKit

/**
 Display an alert message within the specified controller.
 */
func showErrorAlert(_ error: String, controller: UIViewController) {
    let alert = UIAlertController(title: "Error:", message: error, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    controller.present(alert, animated: true)
}

//
//  UIViewController+Extensions.swift
//  onTopPoke
//
//  Created by Vinicius Albino on 20/05/23.
//
import UIKit
import Foundation

extension UIViewController {
    func showErrorAlert() {
        // Create new Alert
        let dialogMessage = UIAlertController(title: "Error", message: "An error ocurred on loading the API. Please try again.", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

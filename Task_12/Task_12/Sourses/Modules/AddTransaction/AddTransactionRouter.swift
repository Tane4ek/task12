//
//  AddTransactionRouter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 23.10.2021.
//

import UIKit

class AddTransactionRouter {
    
    weak var view: UIViewController?
    weak var alert: UIAlertController?
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func returnToWalletModule() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Attention", message: "Wallet name must be more than one character", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view?.present(alert, animated: true, completion: nil)
    }
}

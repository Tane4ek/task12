//
//  TransactionRouter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 11.11.2021.
//

import UIKit

class TransactionRouter {
    
    weak var view: UIViewController?
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func showWalletModule() {
        view?.navigationController?.popViewController(animated: true)
//        view?.dismiss(animated: true, completion: nil)
    }
    
    func showAddTransactionModule(currentWallet: Wallet, currentTransaction: Transaction?) {
        let configurator = AddTransactionModuleConfigurator(serviceContainer: serviceContainer)
        let addTransactionViewController = configurator.configure(currentWallet: currentWallet, currentTransaction: currentTransaction)
//        addTransactionViewController.modalPresentationStyle = .fullScreen
//        view?.present(addTransactionViewController, animated: true, completion: nil)
        view?.navigationController?.pushViewController(addTransactionViewController, animated: true)
    }
}

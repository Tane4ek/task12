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
    }
    
    func showAddTransactionModule(currentWallet: Wallet, currentTransaction: Transaction?) {
        let configurator = AddTransactionModuleConfigurator(serviceContainer: serviceContainer)
        let addTransactionViewController = configurator.configure(currentWallet: currentWallet, currentTransaction: currentTransaction)
        view?.navigationController?.pushViewController(addTransactionViewController, animated: true)
    }
}

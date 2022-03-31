//
//  TransactionHistoryRouter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 23.10.2021.
//

import UIKit

class TransactionHistoryRouter {
    
    weak var view: UIViewController?
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func showTransactionModule(wallet: Wallet, model: Transaction) {
        let configurator = TransactionModuleConfigurator(serviceContainer: serviceContainer)
        let transactionViewController = configurator.configure(wallet: wallet, model: model)
        view?.navigationController?.pushViewController(transactionViewController, animated: true)
    }
    
    func showWalletModule() {
        view?.navigationController?.popViewController(animated: true)
    }
    
}

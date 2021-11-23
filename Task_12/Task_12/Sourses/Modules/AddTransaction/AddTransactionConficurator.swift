//
//  AddTransactionConficurator.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 23.10.2021.
//

import Foundation

final class AddTransactionModuleConfigurator {
    
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func configure(currentWallet: Wallet, currentTransaction: Transaction?) -> AddTransactionViewController {
        let presenter = AddTransactionPresenter(currentWallet: currentWallet, transaction: currentTransaction)
        let view = AddTransactionViewController(presenter: presenter)
        let router = AddTransactionRouter(serviceContainer: serviceContainer)

        presenter.view = view
        presenter.router = router
        presenter.transactionService = serviceContainer.transactionService
        router.serviceContainer = serviceContainer
        router.view = view

        return view
    }
}

//
//  TransactionConfigurator.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 11.11.2021.
//

import Foundation

final class TransactionModuleConfigurator {
    
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func configure(wallet: Wallet, model: Transaction) -> TransactionViewController {
        let presenter = TransactionPresenter(wallet: wallet, transaction: model)
        let view = TransactionViewController(presenter: presenter)
        let router = TransactionRouter(serviceContainer: serviceContainer)
        
        presenter.view = view
        presenter.router = router
        presenter.transactionService = serviceContainer.transactionService
        router.serviceContainer = serviceContainer
        router.view = view

        return view
    }
}

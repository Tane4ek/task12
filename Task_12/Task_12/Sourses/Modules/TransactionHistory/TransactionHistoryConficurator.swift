//
//  TransactionHistoryConficurator.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 23.10.2021.
//

import UIKit

final class TransactionHistoryModuleConfigurator {
    
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func configure(currentWallet: Wallet) -> TransactionHistoryViewController {
        let presenter = TransactionHistoryPresenter(currentWallet: currentWallet)
        let view = TransactionHistoryViewController(presenter: presenter)
        let router = TransactionHistoryRouter(serviceContainer: serviceContainer)
        
        presenter.view = view
        presenter.router = router
        presenter.transactionService = serviceContainer.transactionService
        router.serviceContainer = serviceContainer
        router.view = view
        
        return view
    }
}

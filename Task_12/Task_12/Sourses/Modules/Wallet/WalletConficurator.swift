//
//  WalletConficurator.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 21.10.2021.
//

import Foundation


final class WalletModuleConfigurator {
    
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func configure(model: Wallet) -> WalletViewController {
        let presenter = WalletPresenter(wallet: model)
        let view = WalletViewController(presenter: presenter)
        let router = WalletRouter(serviceContainer: serviceContainer)
        
        presenter.view = view
        presenter.router = router
        presenter.walletService = serviceContainer.walletService
        presenter.transactionService = serviceContainer.transactionService
        router.serviceContainer = serviceContainer
        router.view = view

        return view
    }
}

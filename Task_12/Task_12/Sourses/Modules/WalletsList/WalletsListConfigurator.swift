//
//  WalletsListConfigurator.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 12.10.2021.
//

import UIKit


final class WalletListModuleConfigurator {
    
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func configure() -> WalletsListViewController {
        let presenter = WalletListPresenter()
        let view = WalletsListViewController(presenter: presenter)
        let router = WalletListRouter(serviceContainer: serviceContainer)
        
        presenter.view = view
        presenter.router = router
        presenter.wallerServise = serviceContainer.walletService
        router.serviceContainer = serviceContainer
        router.view = view
        
        return view
    }
}

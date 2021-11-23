//
//  AddWalletConfigurator.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 18.10.2021.
//

import Foundation

final class AddWalletModuleConfigurator {
    
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func configure(wallet: Wallet?) -> AddWalletViewController {
        let presenter = AddWalletPresenter(wallet: wallet)
        let view = AddWalletViewController(presenter: presenter)
        let router = AddWalletRouter(serviceContainer: serviceContainer)

        presenter.view = view
        presenter.router = router
        presenter.walletServise = serviceContainer.walletService
        router.serviceContainer = serviceContainer
        router.view = view

        return view
    }
}

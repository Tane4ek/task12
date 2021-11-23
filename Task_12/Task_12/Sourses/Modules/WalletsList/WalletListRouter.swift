//
//  WalletListRouter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 12.10.2021.
//

import UIKit

class WalletListRouter {
    
    weak var view: UIViewController?
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func showAddWalletModule() {
        let configurator = AddWalletModuleConfigurator(serviceContainer: serviceContainer)
        let addWalletViewController = configurator.configure(wallet: nil)
//        addWalletViewController.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(addWalletViewController, animated: true)
//        view?.present(addWalletViewController, animated: true, completion: nil)
    }
    
    func showWalletModule(wallet: Wallet) {
        let configurator = WalletModuleConfigurator(serviceContainer: serviceContainer)
        let walletViewController = configurator.configure(model: wallet)
//        walletViewController.modalPresentationStyle = .fullScreen
        view?.navigationController?.pushViewController(walletViewController, animated: true)
//        view?.present(walletViewController, animated: true, completion: nil)
    }
    
}

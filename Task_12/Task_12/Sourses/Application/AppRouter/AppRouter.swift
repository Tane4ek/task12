//
//  AppRouter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.10.2021.
//

import Foundation
import UIKit

class AppRouter {
    
    let walletStorageImpl = WalletStorageImpl()
    let walletService: WalletServiceImpl
    let transactionStorageImpl = TransactionStorageImpl()
    let transactionService: TransactionServiceImpl
    let currencyService = CurrencyServiceImpl()
    let colorService = ColorServiceImpl()
    
    let serviceContainer: ServiceContainer
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.walletService = WalletServiceImpl(walletStorageImpl: walletStorageImpl)
        self.transactionService = TransactionServiceImpl(transactionStorageImpl: transactionStorageImpl)
        self.serviceContainer = ServiceContainer(walletService: walletService, transactionService: transactionService, currencyService: currencyService, colorService: colorService)
    }
    
    func openInitialViewController() {
        
        let configurator = WalletListModuleConfigurator(serviceContainer: serviceContainer)
        
        let navigationController = UINavigationController(rootViewController: configurator.configure())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

//
//  AppRouter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.10.2021.
//

import Foundation
import UIKit

class AppRouter {
    
    var walletService = WalletServiceImpl()
    var transactionService = TransactionServiceImpl()
    var currencyService = CurrencyServiceImpl()
    var colorService = ColorServiceImpl()
    
    var serviceContainer: ServiceContainer
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.serviceContainer = ServiceContainer(walletService: walletService, transactionService: transactionService, currencyService: currencyService, colorService: colorService)
    }
    
    func openInitialViewController() {
        
        let configurator = WalletListModuleConfigurator(serviceContainer: serviceContainer)
        
        let navigationController = UINavigationController(rootViewController: configurator.configure())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

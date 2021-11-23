//
//  CurrenciesListViewController.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 05.11.2021.
//

import UIKit

final class CurrenciesListModuleConfigurator {
    
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func configure(output: CurrenciesListModuleOutput) -> CurrenciesListViewController {
        let presenter = CurrenciesListPresenter()
        let view = CurrenciesListViewController(presenter: presenter)
        let router = CurrenciesListRouter(serviceContainer: serviceContainer)
        
        presenter.view = view
        presenter.router = router
        presenter.currencyServise = serviceContainer.currencyService
        presenter.output = output
        router.serviceContainer = serviceContainer
        router.view = view
        
        return view
    }
}


//
//  CurrentColorConfigurator.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.11.2021.
//

import Foundation

final class CurrentColorModuleConfigurator {
    
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func configure(output: CurrentColorModuleOutput, color: String) -> CurrentColorViewController {
        let presenter = CurrentColorPresenter(color: color)
        let view = CurrentColorViewController(presenter: presenter)
        let router = CurrentColorRouter(serviceContainer: serviceContainer)
        
        presenter.view = view
        presenter.router = router
        presenter.colorServise = serviceContainer.colorService
        presenter.output = output
        router.serviceContainer = serviceContainer
        router.view = view
        
        return view
    }
}

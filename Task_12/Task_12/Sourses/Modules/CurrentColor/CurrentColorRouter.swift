//
//  CurrentColorRouter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.11.2021.
//

import UIKit

class CurrentColorRouter {
    
    weak var view: UIViewController?
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func backToAddWalletModule() {
        view?.navigationController?.popViewController(animated: true)
    }
}

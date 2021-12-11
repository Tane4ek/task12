//
//  AddWalletRouter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 18.10.2021.
//

import UIKit

class AddWalletRouter {
    
    weak var view: UIViewController?
    var serviceContainer: ServiceContainer
    weak var alert: UIAlertController?
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func returnToWalletListModule() {
        view?.navigationController?.popToRootViewController(animated: true)
    }
    
    func returnToWalletModule() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func showCurrencyModule(output: CurrenciesListModuleOutput, color: String) {
        let configurator = CurrenciesListModuleConfigurator(serviceContainer: serviceContainer)
        let currenciesListViewController = configurator.configure(output: output, color: color)
        view?.navigationController?.pushViewController(currenciesListViewController, animated: true)
    }
    
    func showCurrentColorModule(output: CurrentColorModuleOutput, color: String) {
        let configurator = CurrentColorModuleConfigurator(serviceContainer: serviceContainer)
        let currentColorViewController = configurator.configure(output: output, color: color)
        view?.navigationController?.pushViewController(currentColorViewController, animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Attention", message: "Wallet name must be more than one character", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view?.present(alert, animated: true, completion: nil)
    }
    
    func showAlertSameWallet() {
        let alert = UIAlertController(title: "Attention", message: "A wallet with the same name already exists", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view?.present(alert, animated: true, completion: nil)
    }
    
}

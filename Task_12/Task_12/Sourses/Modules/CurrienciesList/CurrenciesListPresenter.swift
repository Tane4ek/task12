//
//  CurrienciesListPresenter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 05.11.2021.
//

import Foundation

class CurrenciesListPresenter {
    
    weak var view: CurrenciesListViewInput?
    var models: [Currency] = []
    var router: CurrenciesListRouter?
    var currencyServise: CurrencyService?
    
    weak var output: CurrenciesListModuleOutput?
//    var newWallet: Wallet?
//
//    var walletService: WalletService?
//    var wallet: Wallet?
    

}

extension CurrenciesListPresenter: CurrenciesListViewOutput {
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        models = currencyServise?.currency() ?? []
        view?.reloadUI()
    }
    
    func didSelectRowAt(index: Int) -> Currency {

        let currentCurrency = models[index]
        output?.chooseCurrency(currency: currentCurrency)

        router?.backToAddWalletModule()
        return currentCurrency
    }
    
    func buttonBackTapped() {
        router?.backToAddWalletModule()
    }
    
    func numberOfItems() -> Int {
        return models.count
    }
    
    func modelOfIndex(index: Int) -> Currency {
        let currentModel = models[index]
        return currentModel
    }
}

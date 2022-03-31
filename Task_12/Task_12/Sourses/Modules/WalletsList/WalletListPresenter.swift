//
//  WalletListPresenter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 12.10.2021.
//

import Foundation

class WalletListPresenter {
    
    weak var view: WalletListViewInput?
    var models: [Wallet] = []
    var router: WalletListRouter?
    var wallerServise: WalletService?
    
}

extension WalletListPresenter: WalletListViewOutput {
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        models = wallerServise?.wallets() ?? []
        view?.reloadUI()
    }
    
    func didSelectRowAt(index: Int) {
        let currentWallet = models[index]
        router?.showWalletModule(wallet: currentWallet)
    }
    
    func buttonAddTapped() {
        router?.showAddWalletModule()
    }
    
    func numberOfItems() -> Int {
        return models.count
    }
    
    func modelOfIndex(index: Int) -> Wallet {
        let currentModel = models[index]
        return currentModel
    }
}

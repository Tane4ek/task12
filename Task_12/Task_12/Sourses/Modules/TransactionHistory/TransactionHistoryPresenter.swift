//
//  TransactionHistoryPresenter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 23.10.2021.
//

import Foundation

class TransactionHistoryPresenter {
    
    weak var view: TransactionHistoryViewInput?
    var models: [Transaction] = []
    var router: TransactionHistoryRouter?
    var transactionService: TransactionService?
    var currentWallet: Wallet
    
    init(currentWallet: Wallet){
        self.currentWallet = currentWallet
    }
}

extension TransactionHistoryPresenter: TransactionHistoryViewOutput {
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
//        models = transactionService?.transactionsFromDataBase(walletID: currentWallet.id) ?? []
        models = transactionService?.transactions(walletID: currentWallet.id) ?? []
        view?.reloadUI()
    }
    
    func buttonBackTapped() {
        router?.showWalletModule()
    }
    
    func didSelectRowAt(index: Int) {
        router?.showTransactionModule(wallet: currentWallet, model: models[index])
    }
    
    func numberOfItems() -> Int {
        return models.count
    }
    
    func modelOfIndex(index: Int) -> Transaction {
        let currentModel = models[index]
        return currentModel
    }
    
    func currentModel() -> Wallet {
        let currentWallet = currentWallet
        return currentWallet
    }
}

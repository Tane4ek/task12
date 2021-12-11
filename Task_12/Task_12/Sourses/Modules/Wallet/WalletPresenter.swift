//
//  WalletPresenter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 21.10.2021.
//

import Foundation

class WalletPresenter {
    
    weak var view: WalletViewInput?
    var models: [Transaction] = []
    var router: WalletRouter?
    var transactionService: TransactionService?
    var walletService: WalletService?
    var wallet: Wallet
    
    init(wallet: Wallet) {
        self.wallet = wallet
    }
}

extension WalletPresenter: WalletViewOutput {
    
    func viewDidLoad() {
    }
    
    func viewWillAppear() {
//        models = transactionService?.transactionsFromDataBase(walletID: wallet.id) ?? []
        models = transactionService?.transactions(walletID: wallet.id) ?? []
        wallet.balance = 0
        models.forEach({
            wallet.balance += $0.change })
        walletService?.updateWalletBalance(walletID: wallet.id, balance: wallet.balance)
        for i in 0..<(walletService?.wallets().count)! {
            if  wallet.id == walletService?.wallets()[i].id {
                wallet.name = walletService?.wallets()[i].name ?? ""
                wallet.codeCurrency = walletService?.wallets()[i].codeCurrency ?? ""
                wallet.colorName = walletService?.wallets()[i].colorName ?? ""
            }
        }
        view?.reloadUI()
    }
    
    func currentModel() -> Wallet {
        let currentWallet = wallet
        return currentWallet
    }
    
    func didSelectRowAt(index: Int) {
        let currentTransaction = models[index]
        router?.showTransactionModule(wallet: wallet, transaction: currentTransaction)
    }
    
    func modelOfIndex(index: Int) -> Transaction {
        let currentModel = models[index]
        return currentModel
    }
    
    func buttonBackTapped() {
        router?.returnToWalletListModule()
    }
    
    func buttonAllTapped() {
        router?.showTransactionHistoryModule(currentWallet: wallet)
    }
    
    func buttonAddTapped() {
        router?.showAddTransactionModule(currentWallet: wallet, currentTransaction: nil)
    }
    
    func buttonSettingsTapped() {
        router?.showEditWallet(wallet: wallet)
    }
    
    func numberOfItems() -> Int {
        return models.count
    }
}

//
//  TransactionPresenter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 11.11.2021.
//

import Foundation

class TransactionPresenter {
    
    weak var view: TransactionViewInput?
    
    var router: TransactionRouter?
    var transactionService: TransactionService?
    var walletService: WalletService?
    var transaction: Transaction
    var wallet: Wallet
    
    init(wallet: Wallet, transaction: Transaction) {
        self.wallet = wallet
        self.transaction = transaction
    }
}

extension TransactionPresenter: TransactionViewOutput {
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        guard let cnt = transactionService?.transactions(walletID: wallet.id) else { return }
        for i in 0..<cnt.count {
            if transaction.id == cnt[i].id {
                transaction.title = cnt[i].title
                transaction.change = cnt[i].change
                transaction.note = cnt[i].note
            }
        }
        view?.reloadUI()
    }
    
    func currentModel() -> Transaction {
        let currentModel = transaction
        return currentModel
    }
    
    func buttonBackTapped() {
        router?.showWalletModule()
    }
    
    func buttonDeleteTapped() {
        transactionService?.deleteTransaction(walletID: wallet.id, transaction: transaction)
        router?.showWalletModule()
    }
    
    func buttonEditTapped() {
        router?.showAddTransactionModule(currentWallet: wallet, currentTransaction: transaction)
    }
    
    func numberOfItems() -> Int {
        return 1
    }
    
    
}

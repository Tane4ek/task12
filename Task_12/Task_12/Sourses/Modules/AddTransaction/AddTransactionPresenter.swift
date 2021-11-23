//
//  Add TransactionPresenter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 23.10.2021.
//

import Foundation
class AddTransactionPresenter {
    
    weak var view: AddTransactionViewInput?
    var newTransaction: Transaction?
    var router: AddTransactionRouter?
    var transactionService: TransactionService?
    
    var currentWallet: Wallet
    var transaction: Transaction?
    init(currentWallet: Wallet, transaction: Transaction?){
        self.currentWallet = currentWallet
        self.transaction = transaction
    }
}

extension AddTransactionPresenter: AddTransactionViewOutput {
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        view?.reloadUI()
    }
    
    func currentUserWallet () -> Wallet {
        let currentWallet = currentWallet
        return currentWallet
    }
    
    func currentModel() -> Transaction {
        var currentTransaction: Transaction?
        if transaction != nil {
            currentTransaction = transaction
        } else if newTransaction != nil {
            currentTransaction = newTransaction
        } else {
            currentTransaction = Transaction(id: UUID(), title: "", change: 0.0, date: Date.now, note: "", codeCurrency: currentWallet.codeCurrency, colorName: currentWallet.colorName)
        }
        return currentTransaction!
    }
    
    func addTitle(title: String) {
        if transaction != nil {
            transactionService?.updateTransactionTitle(walletID: currentWallet.id, transaction: transaction!, title: title)
            print("transaction \(transaction)")
        } else if newTransaction != nil {
            newTransaction?.title = title
        } else {
            newTransaction = Transaction(id: UUID(), title: title, change: 0.0, date: Date.now, note: "", codeCurrency: currentWallet.codeCurrency, colorName: currentWallet.colorName)
        }
        print("add title", newTransaction)
    }
    func addChange(change: Double) {
        if transaction != nil {
            transactionService?.updateTransactionBalance(walletID: currentWallet.id, transaction: transaction!, change: change)
            print("transaction \(transaction)")
        } else if newTransaction != nil {
            newTransaction?.change = change
        } else {
            newTransaction = Transaction(id: UUID(), title: "", change: change, date: Date.now, note: "", codeCurrency: currentWallet.codeCurrency, colorName: currentWallet.colorName)
        }
        print("add Change", newTransaction)
    }
    
    func addNote(note: String) {
        if transaction != nil {
            transactionService?.updateTransactionNote(walletID: currentWallet.id, transaction: transaction!, note: note)
            print("transaction \(transaction)")
        } else if newTransaction != nil {
            newTransaction?.note = note
        }
        print("Add note", newTransaction)
    }
    
    func segmentControlTapped() {
        
    }
    
    func didSelectRowAt() {
        
    }
    
    func currentLabel() -> String {
        var currentLabel = ""
        if transaction == nil {
            currentLabel = "Add transaction"
        } else {
            currentLabel = "Edit transaction"
        }
        return currentLabel
    }
    
    func buttonBackTapped(wallet: Wallet) {
        if newTransaction == nil {
            router?.returnToWalletModule()
        }
        guard newTransaction != nil else {return}
        transactionService?.addNewTransaction(walletID: wallet.id, transaction: newTransaction!)
        router?.returnToWalletModule()
    }
    
    func numberOfItems() -> Int {
        return 1
    }
}

//
//  Add TransactionPresenter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 23.10.2021.
//

import Foundation
class AddTransactionPresenter {
    
    weak var view: AddTransactionViewInput?
    var router: AddTransactionRouter?
    var transactionService: TransactionService?
    
    var currentWallet: Wallet
    var transaction: Transaction
    let isEditMode: Bool
    
    init(currentWallet: Wallet, transaction: Transaction?){
        self.currentWallet = currentWallet
        isEditMode = transaction != nil
        self.transaction = transaction ?? Transaction(id: UUID(), title: "", change: 0.0, date: Date.now, note: "", codeCurrency: currentWallet.codeCurrency, colorName: currentWallet.colorName)
    }
}

extension AddTransactionPresenter: AddTransactionViewOutput {
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        view?.reloadUI()
    }
    
    func currentUserWallet () -> Wallet {
        return currentWallet
    }
    
    func currentModel() -> Transaction {
        return transaction
    }
    
    func addTitle(title: String) {
        transaction.title = title
        print("add title", transaction)
    }
    func addChange(change: Double) {
        transaction.change = change
        print("add Change", transaction)
    }
    
    func addNote(note: String) {
        transaction.note = note
        print("Add note", transaction)
    }
    
    func segmentControlTapped() {
    }
    
    func didSelectRowAt() {
    }
    
    func currentLabel() -> String {
        isEditMode ? "Edit transaction" : "Add transaction"
    }
    
    func buttonBackTapped(wallet: Wallet) {
        router?.returnToWalletModule()
    }
    
    func buttonSaveTapped(wallet: Wallet) {
        if transaction.title.isEmpty {
            router?.showAlert()
        }
        let result = transactionService?.updateTransactionIfCan(wallet: currentWallet, transaction: transaction)
        if result  == true {
            router?.returnToWalletModule()
        }
    }
    
    func numberOfItems() -> Int {
        return 1
    }
}

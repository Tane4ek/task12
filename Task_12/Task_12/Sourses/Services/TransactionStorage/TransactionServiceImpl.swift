//
//  TransactionServiceImpl.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.10.2021.
//

import Foundation

class TransactionServiceImpl {
    
    var userTransaction: [UUID: [Transaction]] = [:]
}

extension TransactionServiceImpl: TransactionService {
    
    func transactions(walletID: UUID) -> [Transaction] {
        let currentTransaction = userTransaction[walletID] ?? []
        return currentTransaction
    }
    
    func addNewTransaction(walletID: UUID, transaction: Transaction) {
        if userTransaction[walletID] == nil {
            userTransaction[walletID] = []
        }
        userTransaction[walletID]?.append(transaction)
        print(TransactionServiceImpl().userTransaction)
    }
    
    func deleteTransaction(walletID: UUID, transaction: Transaction) {
        guard let cnt = userTransaction[walletID] else { return }
        for i in 0..<cnt.count {
            if cnt[i].id == transaction.id {
                userTransaction[walletID]?.remove(at: i)
            }
        }
    }
    
    func updateTransactionTitle(walletID: UUID, transaction: Transaction, title: String) {
        guard let cnt = userTransaction[walletID] else { return }
        for i in 0..<cnt.count {
            if cnt[i].id == transaction.id {
                userTransaction[walletID]?[i].title = title
            }
        }
    }
    
    func updateTransactionBalance(walletID: UUID, transaction: Transaction, change: Double) {
        guard let cnt = userTransaction[walletID] else { return }
        for i in 0..<cnt.count {
            if cnt[i].id == transaction.id {
                userTransaction[walletID]?[i].change = change
            }
        }
    }
    
    func updateTransactionNote(walletID: UUID, transaction: Transaction, note: String) {
        guard let cnt = userTransaction[walletID] else { return }
        for i in 0..<cnt.count {
            if cnt[i].id == transaction.id {
                userTransaction[walletID]?[i].note = note
            }
        }
    }
}

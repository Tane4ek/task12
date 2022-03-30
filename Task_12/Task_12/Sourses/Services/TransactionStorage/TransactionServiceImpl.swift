//
//  TransactionServiceImpl.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.10.2021.
//

import Foundation
import CoreData
import UIKit

class TransactionServiceImpl {
    
    var userTransaction: [UUID: [Transaction]] = [:]
    var storedUserWallet: [Wallets] = []
    var storedUserTransactions: [Transactions] = []
    
    var transactionStorageImpl = TransactionStorageImpl()
    
    init(transactionStorageImpl: TransactionStorageImpl) {
        self.transactionStorageImpl = transactionStorageImpl
    }
}

extension TransactionServiceImpl: TransactionService {
    
    func transactions(walletID: UUID) -> [Transaction] {
        let currentTransaction = transactionStorageImpl.transactionsFromDataBase(walletID: walletID)
        return currentTransaction
    }
    
    func updateTransactionIfCan(wallet: Wallet, transaction: Transaction) -> Bool {
        
        var needAppear = true
        userTransaction[wallet.id] = transactionStorageImpl.transactionsFromDataBase(walletID: wallet.id)
        if userTransaction[wallet.id] == nil {
            userTransaction[wallet.id] = []
        }
        
        for i in 0..<userTransaction[wallet.id]!.count {
            if userTransaction[wallet.id]![i].id == transaction.id {
                userTransaction[wallet.id]![i] = transaction
                needAppear = false
                transactionStorageImpl.updateTransactionInDB(transaction: transaction)
                break
            }
        }
        if needAppear {
            userTransaction[wallet.id]!.append(transaction)
            transactionStorageImpl.saveToDataBase(wallet: wallet, transaction: transaction)
        }
        return true
    }
    
    func deleteTransaction(walletID: UUID, transaction: Transaction) {
        transactionStorageImpl.deleteTransactionFromDB(transactionID: transaction.id)
        
        guard let cnt = userTransaction[walletID] else { return }
        for i in 0..<cnt.count {
            if cnt[i].id == transaction.id {
                userTransaction[walletID]?.remove(at: i)
            }
        }
    }
}

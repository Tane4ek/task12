//
//  TransactionServiceImpl.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.10.2021.
//

import Foundation
import UIKit

class TransactionServiceImpl {
    
    var userTransaction: [UUID: [Transaction]] = [:]
    var storedUserWallet: [Wallets] = []
}

extension TransactionServiceImpl: TransactionService {
    
    func transactions(walletID: UUID) -> [Transaction] {
        let currentTransaction = userTransaction[walletID] ?? []
        return currentTransaction
    }
    
    func updateTransactionIfCan(wallet: Wallet, transaction: Transaction) -> Bool {
        
        var needAppear = true

        if userTransaction[wallet.id] == nil {
            userTransaction[wallet.id] = []
        }
        
        for i in 0..<userTransaction[wallet.id]!.count {
            if userTransaction[wallet.id]![i].id == transaction.id {
                userTransaction[wallet.id]![i] = transaction
                needAppear = false
                break
            }
        }
        if needAppear {
            userTransaction[wallet.id]!.append(transaction)
        }
        return true
    }
    
    func deleteTransaction(walletID: UUID, transaction: Transaction) {
//        deleteTransactionFromDB(transactionID: transaction.id)
        
        guard let cnt = userTransaction[walletID] else { return }
        for i in 0..<cnt.count {
            if cnt[i].id == transaction.id {
                userTransaction[walletID]?.remove(at: i)
            }
        }
    }
}

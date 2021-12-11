//
//  TransactionService.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.10.2021.
//

import Foundation
import CoreData

protocol TransactionService {
    
    func transactions(walletID: UUID) -> [Transaction]
    
    func updateTransactionIfCan(wallet: Wallet, transaction: Transaction) -> Bool
    
    func deleteTransaction(walletID: UUID, transaction: Transaction)
    
}

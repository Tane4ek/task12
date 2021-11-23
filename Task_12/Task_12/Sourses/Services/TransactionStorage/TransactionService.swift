//
//  TransactionService.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.10.2021.
//

import Foundation

protocol TransactionService {
    
    func transactions(walletID: UUID) -> [Transaction]
    
    func addNewTransaction(walletID: UUID, transaction: Transaction)
    
    func deleteTransaction(walletID: UUID, transaction: Transaction)
    
    func updateTransactionTitle(walletID: UUID, transaction: Transaction, title: String)
    
    func updateTransactionBalance(walletID: UUID, transaction: Transaction, change: Double)
    
    func updateTransactionNote(walletID: UUID, transaction: Transaction, note: String)
}

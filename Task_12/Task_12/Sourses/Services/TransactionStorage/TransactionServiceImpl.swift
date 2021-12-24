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
    var storedUserTransactions: [Transactions] = []
    var storedUserWallet: [Wallets] = []
}

extension TransactionServiceImpl: TransactionService {
    
    func transactions(walletID: UUID) -> [Transaction] {
        let currentTransaction = userTransaction[walletID] ?? []
        return currentTransaction
    }
    
    func updateTransactionIfCan(wallet: Wallet, transaction: Transaction) -> Bool {
        
        var needAppear = true
        userTransaction[wallet.id] = transactionsFromDataBase(walletID: wallet.id)
        if userTransaction[wallet.id] == nil {
            userTransaction[wallet.id] = []
        }
        
        for i in 0..<userTransaction[wallet.id]!.count {
            if userTransaction[wallet.id]![i].id == transaction.id {
                userTransaction[wallet.id]![i] = transaction
                needAppear = false
                updateTransactionInDB(transaction: transaction)
                break
            }
        }
        if needAppear {
            userTransaction[wallet.id]!.append(transaction)
            saveToDataBase(wallet: wallet, transaction: transaction)
        }
        return true
    }
    
    func deleteTransaction(walletID: UUID, transaction: Transaction) {
        deleteTransactionFromDB(transactionID: transaction.id)
        
        guard let cnt = userTransaction[walletID] else { return }
        for i in 0..<cnt.count {
            if cnt[i].id == transaction.id {
                userTransaction[walletID]?.remove(at: i)
            }
        }
    }
    
    func createManagedContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        return managedContext
    }
    
    func createRequestForWalletID(walletID: UUID) -> NSFetchRequest<Wallets> {
        let fetchRequest: NSFetchRequest<Wallets> = Wallets.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", walletID as CVarArg)
        return fetchRequest
    }
    
    func createRequestForWalletIDFromTransaction(walletID: UUID) -> NSFetchRequest<Transactions> {
        let fetchRequest: NSFetchRequest<Transactions> = Transactions.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "fromWallet.id = %@", walletID as CVarArg)
        return fetchRequest
    }
    
    func createRequestForTransactionID(transactionId: UUID) -> NSFetchRequest<Transactions> {
        let fetchRequest: NSFetchRequest<Transactions> = Transactions.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", transactionId as CVarArg)
        return fetchRequest
    }
    
    func saveToDataBase(wallet: Wallet, transaction: Transaction) {
        //         Создать ManagedObject из Transaction и сохранить его
        let managedContext = createManagedContext()
        
        let transactionEntity = NSEntityDescription.entity(forEntityName: "Transactions", in: managedContext!)!
        
        let userTransactions = Transactions(entity: transactionEntity, insertInto: managedContext)
        
        let walletFetchRequest: NSFetchRequest<Wallets> = Wallets.fetchRequest()
        walletFetchRequest.predicate = NSPredicate(format: "id = %@", wallet.id as CVarArg)
        
        do {
            storedUserWallet = try managedContext!.fetch(walletFetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        var currentStoredUserWallet: Wallets?
        
        for i in 0..<storedUserWallet.count {
            if storedUserWallet[i].id == wallet.id
            {
                currentStoredUserWallet = storedUserWallet[i]
            }
        }
        
        userTransactions.id = transaction.id
        userTransactions.title = transaction.title
        userTransactions.change = transaction.change
        userTransactions.note = transaction.note
        userTransactions.colorName = wallet.colorName
        userTransactions.codeCurrency = wallet.codeCurrency
        userTransactions.date = transaction.date
        userTransactions.fromWallet = currentStoredUserWallet
        
        do {
            try managedContext!.save()
            storedUserTransactions.append(userTransactions)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func transactionsFromDataBase(walletID: UUID) -> [Transaction] {
        // Получить все ManagedObject и конвертировать их в [Transaction]
        
        var transactionFromDB: [Transaction] = []
        let managedContext = createManagedContext()
        
        let transactionFetchRequest = createRequestForWalletIDFromTransaction(walletID: walletID)
        let walletFetchRequest = createRequestForWalletID(walletID: walletID)
        do {
            storedUserTransactions = try managedContext!.fetch(transactionFetchRequest)
            storedUserWallet = try managedContext!.fetch(walletFetchRequest)
            
            storedUserTransactions.forEach { let transaction = Transaction(id: $0.id!, title: $0.title!, change: $0.change, date: $0.date!, note: $0.note!, codeCurrency: storedUserWallet.first?.codeCurrency ?? "", colorName: (storedUserWallet.first?.colorName)!)
                transactionFromDB.append(transaction)
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return transactionFromDB
    }
    
    func deleteTransactionFromDB(transactionID: UUID) {
        //        удаляем кошелек из ManagedObject
        let managedContext = createManagedContext()
        
        let fetchRequest = createRequestForTransactionID(transactionId: transactionID)
        
        if let storedUserTransaction = try? managedContext!.fetch(fetchRequest) {
            managedContext!.delete(storedUserTransaction.first!)
            
            do {
                try managedContext!.save()
            } catch let error as NSError {
                print("Could not delete. \(error), \(error.userInfo)")
            }
        }
    }
    
    func updateTransactionInDB(transaction: Transaction) {
        let managedContext = createManagedContext()
        
        let fetchRequest = createRequestForTransactionID(transactionId: transaction.id)
        
        storedUserTransactions = try! managedContext!.fetch(fetchRequest)
        storedUserTransactions.first?.title = transaction.title
        storedUserTransactions.first?.change = transaction.change
        storedUserTransactions.first?.note = transaction.note
        
        do {
            try managedContext!.save()
            
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
    
}

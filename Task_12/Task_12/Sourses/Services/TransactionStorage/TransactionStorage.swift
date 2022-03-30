//
//  File.swift
//  Task_12
//
//  Created by Tatiana Luzanova on 29.03.2022.
//

import Foundation
import UIKit
import CoreData

protocol TransactionStorage {
    
    func saveToDataBase(wallet: Wallet, transaction: Transaction)
    
    func updateTransactionInDB(transaction: Transaction)
    
    func transactionsFromDataBase(walletID: UUID) -> [Transaction]
    
    func deleteTransactionFromDB(transactionID: UUID)
    
    func createRequestForWalletID(walletID: UUID) -> NSFetchRequest<Wallets>
}


class TransactionStorageImpl {
    
    var storedUserTransactions: [Transactions] = []
    var storedUserWallet: [Wallets] = []
    
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
        fetchRequest.predicate = NSPredicate(format: "fromwallet.id = %@", walletID as CVarArg)
        return fetchRequest
    }
    
    func createRequestForTransactionID(transactionID: UUID) -> NSFetchRequest<Transactions> {
        let fetchRequest: NSFetchRequest<Transactions> = Transactions.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", transactionID as CVarArg)
        return fetchRequest
    }
}

extension TransactionStorageImpl: TransactionStorage {
    
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
            print("Coud not fetch. \(error), \(error.userInfo)")
        }
        
        userTransactions.id = transaction.id
        userTransactions.title = transaction.title
        userTransactions.change = transaction.change
        userTransactions.note = transaction.note
        userTransactions.colorName = wallet.colorName
        userTransactions.codeCurrency = wallet.codeCurrency
        userTransactions.date = transaction.date
        userTransactions.fromwallet = storedUserWallet.first
        
        do {
            try managedContext!.save()
            storedUserTransactions.append(userTransactions)
        } catch let error as NSError {
            print("Coud not save. \(error), \(error.userInfo)")
        }
    }
    
    func updateTransactionInDB(transaction: Transaction) {
        let managedContext = createManagedContext()
        
        let fetchRequest = createRequestForTransactionID(transactionID: transaction.id)
        
        storedUserTransactions = try! managedContext!.fetch(fetchRequest)
        storedUserTransactions.first?.title = transaction.title
        storedUserTransactions.first?.change = transaction.change
        storedUserTransactions.first?.note = transaction.note
        
        do {
            try managedContext!.save()
        } catch let error as NSError {
            print("Cound not update. \(error), \(error.userInfo)")
        }
    }
    
    func transactionsFromDataBase(walletID: UUID) -> [Transaction] {
        var transactionsFromDB: [Transaction] = []
        let managedContext = createManagedContext()
        
        let walletsFetchRequest = createRequestForWalletID(walletID: walletID)
        let transactionFetchRequest = createRequestForWalletIDFromTransaction(walletID: walletID)
        do {
            storedUserWallet = try managedContext!.fetch(walletsFetchRequest)
            storedUserTransactions = try managedContext!.fetch(transactionFetchRequest)
            storedUserTransactions.forEach { let transaction = Transaction(id: $0.id!, title: $0.title!, change: $0.change, date: $0.date!, note: $0.note!, codeCurrency: storedUserWallet.first?.codeCurrency ?? "", colorName: (storedUserWallet.first?.colorName)!)
                transactionsFromDB.append(transaction)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return transactionsFromDB
    }
    
    func deleteTransactionFromDB(transactionID: UUID) {
        // удаляем транзакцию из ManagedObject
        let managedContext = createManagedContext()
        
        let fetchRequest = createRequestForTransactionID(transactionID: transactionID)
        
        storedUserTransactions = try! managedContext!.fetch(fetchRequest)
        managedContext!.delete(storedUserTransactions.first!)
        
        do {
            try managedContext!.save()
        } catch let error as NSError {
            print("Cound not delete. \(error), \(error.userInfo)")
        }
    }
}


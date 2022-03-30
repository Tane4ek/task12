//
//  WalletStorage.swift
//  Task_12
//
//  Created by Татьяна Лузанова  on 14.12.2021.
//

import Foundation
import UIKit
import CoreData

protocol WalletStorage {
    
    func saveToDataBase(wallet: Wallet)
    
    func walletsFromDataBase() -> [Wallet]
    
    func createRequestForWalletID(walletID: UUID) -> NSFetchRequest<Wallets>
    
    func deleteFromDataBase(walletID: UUID)
    
    func updateInDataBase(wallet: Wallet)
    
    func updateWalletBalanceInDataBase(walletID: UUID, balance: Double)
}


class WalletStorageImpl {
   
    var storedUserWallets: [Wallets] = []
    
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
    
  }

extension WalletStorageImpl: WalletStorage {
   
    func saveToDataBase(wallet: Wallet) {
//         Создать ManagedObject из Wallet и сохранить его
        
        let managedContext = createManagedContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Wallets", in: managedContext!)!
        let userWallet = Wallets(entity: entity, insertInto: managedContext)
        
        userWallet.name = wallet.name
        userWallet.id = wallet.id
        userWallet.balance = wallet.balance
        userWallet.colorName = wallet.colorName
        userWallet.codeCurrency = wallet.codeCurrency
        userWallet.dateOfLastChange = wallet.dateOfLastChange
        
        do {
            try managedContext?.save()
            storedUserWallets.append(userWallet)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func walletsFromDataBase() -> [Wallet] {
// Получить все ManagedObject и конвертировать их в [Wallet]
        var walletsFromDB: [Wallet] = []
        let managedContext = createManagedContext()
        
        let fetchRequest: NSFetchRequest<Wallets> = Wallets.fetchRequest()
        do {
            storedUserWallets = try managedContext!.fetch(fetchRequest)
            storedUserWallets.forEach { let wallet = Wallet(id: $0.id!, name: $0.name!, balance: $0.balance, dateOfLastChange: $0.dateOfLastChange!, codeCurrency: $0.codeCurrency!, colorName: $0.colorName!)
                walletsFromDB.append(wallet)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return walletsFromDB
    }
    
    func deleteFromDataBase(walletID: UUID) {
//        удаляем кошелек из ManagedObject
        let managedContext = createManagedContext()
        let fetchRequest = createRequestForWalletID(walletID: walletID)
        
        storedUserWallets = try! managedContext!.fetch(fetchRequest)
        managedContext!.delete(storedUserWallets.first!)
        
        do {
            try managedContext!.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    func updateInDataBase(wallet: Wallet) {
        let managedContext = createManagedContext()
        let fetchRequest = createRequestForWalletID(walletID: wallet.id)
        
        storedUserWallets = try! managedContext!.fetch(fetchRequest)
        
        storedUserWallets.first?.name = wallet.name
        storedUserWallets.first?.codeCurrency = wallet.codeCurrency
        storedUserWallets.first?.colorName = wallet.colorName
        
        do {
            try managedContext!.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func updateWalletBalanceInDataBase(walletID: UUID, balance: Double) {
        let managedContext = createManagedContext()
        let fetchRequest = createRequestForWalletID(walletID: walletID)
        
        storedUserWallets = try! managedContext!.fetch(fetchRequest)
        for storedWallet in storedUserWallets {
            if storedWallet.id == walletID {
                storedWallet.balance = balance
            }
        }
        do {
            try managedContext!.save()
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
}

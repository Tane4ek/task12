//
//  WalletServiceImpl.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.10.2021.
//

import Foundation
import CoreData
import UIKit

class WalletServiceImpl {
    
    var userWallets: [Wallet] = []
    var storedUserWallets: [NSManagedObject] = []
}

extension WalletServiceImpl: WalletService {
    
    func wallets() -> [Wallet] {
        
        return userWallets
    }
    
    func updateWalletIfCan(wallet: Wallet) -> Bool {
        guard userWallets.contains(where: { $0.name == wallet.name && $0.id != wallet.id}
        ) == false
        else { return false }
        
        var needAppear = true
        userWallets = walletsFromDataBase() ?? []
        for i in 0..<userWallets.count {
            if userWallets[i].id == wallet.id {
                userWallets[i] = wallet
                needAppear = false
                updateInDataBase(wallet: wallet)
                break
            }
        }
        if needAppear {
            userWallets.append(wallet)
            saveToDataBase(wallet: wallet)
        }
        return true
    }
    
    func updateWalletBalance(walletID: UUID, balance: Double) {
        for i in 0..<userWallets.count {
            if userWallets[i].id == walletID {
                userWallets[i].balance = balance
            }
        }
        updateWalletBalanceInDataBase(walletID: walletID, balance: balance)
    }
    
    func deleteWallet(walletID: UUID) {
        deleteFromDataBase(walletID: walletID)
        
        for i in 0..<userWallets.count {
            print(" кошельки до удаления \(userWallets)")
            if userWallets[i].id == walletID {
                userWallets.remove(at: i)
                break
            }
        }
        print(" кошельки после удаления \(userWallets)")
        
    }
    
    func createManagedContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        return managedContext
    }
    
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
    
    func walletsFromDataBase() -> [Wallet]? {
        // Получить все ManagedObject и конвертировать их в [Wallet]
        var walletsFromDB: [Wallet] = []
        let managedContext = createManagedContext()

        let fetchRequest: NSFetchRequest<Wallets> = Wallets.fetchRequest()
        do {
            let userWalletsInDataBase = try managedContext!.fetch(fetchRequest)
            userWalletsInDataBase.forEach { let wallet = Wallet(id: $0.id!, name: $0.name!, balance: $0.balance, dateOfLastChange: $0.dateOfLastChange!, codeCurrency: $0.codeCurrency!, colorName: $0.colorName!)
                walletsFromDB.append(wallet)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        //        storedUserWallets.forEach { let wallet = Wallet(id: $0.value(forKey: "id") as! UUID, name: $0.value(forKey: "name") as? String ?? "", balance: $0.value(forKey: "balance") as! Double, dateOfLastChange: $0.value(forKey: "dateOfLastChange") as! Date, codeCurrency: $0.value(forKey: "codeCurrency") as! String, colorName: $0.value(forKey: "colorName") as! String)
        //            walletsFromDB.append(wallet)
        //        }
        return walletsFromDB
    }
    
    func createRequestForWalletID(walletID: UUID) -> NSFetchRequest<Wallets> {
        let fetchRequest: NSFetchRequest<Wallets> = Wallets.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", walletID as CVarArg)
        return fetchRequest
    }
    
    func deleteFromDataBase(walletID: UUID) {
//        удаляем кошелек из ManagedObject
        let managedContext = createManagedContext()
        let fetchRequest = createRequestForWalletID(walletID: walletID)
        
        if let storedUserWallets = try? managedContext!.fetch(fetchRequest) {
            managedContext!.delete(storedUserWallets.first!)
            
            do {
                try managedContext!.save()
            } catch let error as NSError {
                print("Could not delete. \(error), \(error.userInfo)")
            }
        }
    }
    
    func updateInDataBase(wallet: Wallet) {
        let managedContext = createManagedContext()
        let fetchRequest = createRequestForWalletID(walletID: wallet.id)
        
            if let currentUserWallet = try? managedContext!.fetch(fetchRequest) {

                currentUserWallet.first?.name = wallet.name
                currentUserWallet.first?.codeCurrency = wallet.codeCurrency
                currentUserWallet.first?.colorName = wallet.colorName
                
                do {
                    try managedContext!.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
    }
    
    func updateWalletBalanceInDataBase(walletID: UUID, balance: Double) {
        let managedContext = createManagedContext()
        let fetchRequest = createRequestForWalletID(walletID: walletID)
        
        if let storedUserWallets = try? managedContext!.fetch(fetchRequest) {
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
}

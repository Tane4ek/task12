//
//  WalletService.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.10.2021.
//

import Foundation
import CoreData

protocol WalletService {
    
    func wallets() -> [Wallet]
    
    func updateWalletIfCan(wallet: Wallet) -> Bool
    
    func updateWalletBalance(walletID: UUID, balance: Double)

    func deleteWallet(walletID: UUID)
    
    func createManagedContext() -> NSManagedObjectContext?
    
    func saveToDataBase(wallet: Wallet)

    func walletsFromDataBase() -> [Wallet]?
    
    func deleteFromDataBase(walletID: UUID)
    
    func updateInDataBase(wallet: Wallet)
    
    func updateWalletBalanceInDataBase(walletID: UUID, balance: Double)
}

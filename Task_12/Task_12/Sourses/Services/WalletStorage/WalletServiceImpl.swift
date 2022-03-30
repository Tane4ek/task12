//
//  WalletServiceImpl.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.10.2021.
//

import Foundation
import UIKit

class WalletServiceImpl {
    
    var userWallets: [Wallet] = []
    
    var walletStorageImpl: WalletStorageImpl
    
    init(walletStorageImpl: WalletStorageImpl) {
        self.walletStorageImpl = walletStorageImpl
    }
}

extension WalletServiceImpl: WalletService {
    
    func wallets() -> [Wallet] {
        
        return walletStorageImpl.walletsFromDataBase()
    }
    
    func updateWalletIfCan(wallet: Wallet) -> Bool {
        guard userWallets.contains(where: { $0.name == wallet.name && $0.id != wallet.id}
        ) == false
        else { return false }
        
        var needAppear = true
        userWallets = walletStorageImpl.walletsFromDataBase()
        for i in 0..<userWallets.count {
            if userWallets[i].id == wallet.id {
                userWallets[i] = wallet
                needAppear = false
                walletStorageImpl.updateInDataBase(wallet: wallet)
                break
            }
        }
        if needAppear {
            userWallets.append(wallet)
            walletStorageImpl.saveToDataBase(wallet: wallet)
        }
        return true
    }
    
    func updateWalletBalance(walletID: UUID, balance: Double) {
        for i in 0..<userWallets.count {
            if userWallets[i].id == walletID {
                userWallets[i].balance = balance
            }
        }
        walletStorageImpl.updateWalletBalanceInDataBase(walletID: walletID, balance: balance)
    }
    
    func deleteWallet(walletID: UUID) {
        walletStorageImpl.deleteFromDataBase(walletID: walletID)
        
        for i in 0..<userWallets.count {
            print(" кошельки до удаления \(userWallets)")
            if userWallets[i].id == walletID {
                userWallets.remove(at: i)
                break
            }
        }
        print(" кошельки после удаления \(userWallets)")
        
    }
}

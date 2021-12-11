//
//  WalletServiceImpl.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.10.2021.
//

import Foundation

class WalletServiceImpl {
    
    var userWallets: [Wallet] = []
}

extension WalletServiceImpl: WalletService {
    
    func wallets() -> [Wallet] {
        return userWallets
    }
    
    func updateWalletIfCan(wallet: Wallet)-> Bool {
        guard userWallets.contains(where: { $0.name == wallet.name && $0.id != wallet.id}
        ) == false
        else {return false}
        
        var needAppear = true
        for i in 0..<userWallets.count {
            if userWallets[i].id == wallet.id {
                userWallets[i] = wallet
                needAppear = false
                break
            }
        }
        
        if needAppear {
            userWallets.append(wallet)
        }
        
        return true
    }
    
    func updateWalletBalance(walletID: UUID, balance: Double) {
        for i in 0..<userWallets.count {
            if userWallets[i].id == walletID {
                userWallets[i].balance = balance
            }
        }
    }
    
    func deleteWallet(walletID: UUID) {
        for i in 0..<userWallets.count {
            if userWallets[i].id == walletID {
                userWallets.remove(at: i)
            }
        }
    }
}

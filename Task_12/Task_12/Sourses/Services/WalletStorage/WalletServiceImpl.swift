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
    
    func addNewWallet(wallet: Wallet) {
        userWallets.append(wallet)
    }
    
    func updateWalletBalance(walletID: UUID, balance: Double) {
        for i in 0..<userWallets.count {
            if userWallets[i].id == walletID {
                userWallets[i].balance = balance
            }
        }
    }
    
    func updadeWalletName(walletID: UUID, name: String) {
        for i in 0..<userWallets.count {
            if userWallets[i].id == walletID {
                userWallets[i].name = name
            }
        }
    }
    
    func updateWalletCurrency(walletID: UUID, currentCode: String) {
        for i in 0..<userWallets.count {
            if userWallets[i].id == walletID {
                userWallets[i].codeCurrency = currentCode
            }
        }
    }
    
    func updateWalletColor(walletID: UUID, colorName: String) {
        for i in 0..<userWallets.count {
            if userWallets[i].id == walletID {
                userWallets[i].colorName = colorName
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

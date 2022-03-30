//
//  WalletService.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.10.2021.
//

import Foundation

protocol WalletService {
    
    func wallets() -> [Wallet]
    
    func updateWalletIfCan(wallet: Wallet) -> Bool
    
    func updateWalletBalance(walletID: UUID, balance: Double)

    func deleteWallet(walletID: UUID)
    
}

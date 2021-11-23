//
//  WalletService.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.10.2021.
//

import Foundation

protocol WalletService {
    
    func wallets() -> [Wallet]
    
    func addNewWallet(wallet: Wallet)
    
    func updateWalletBalance(walletID: UUID, balance: Double)
    
    func updadeWalletName(walletID: UUID, name: String)
    
    func updateWalletCurrency(walletID: UUID, currentCode: String)
    
    func updateWalletColor(walletID: UUID, colorName: String)
    
    func deleteWallet(walletID: UUID)
}

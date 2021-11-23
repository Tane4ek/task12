//
//  WalletProtocols.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 21.10.2021.
//

import Foundation

protocol WalletViewInput: AnyObject {
    
    func reloadUI()
}

protocol WalletViewOutput: AnyObject {
    
    func viewDidLoad()
    
    func viewWillAppear()
    
    func currentModel() -> Wallet
    
    func buttonBackTapped()
    
    func buttonAllTapped()
    
    func buttonAddTapped()
    
    func buttonSettingsTapped()
    
    func didSelectRowAt(index: Int)
    
    func modelOfIndex(index: Int) -> Transaction
    
    func numberOfItems() -> Int
}

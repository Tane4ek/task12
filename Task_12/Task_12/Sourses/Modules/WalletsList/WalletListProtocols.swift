//
//  WalletListProtocols.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 13.10.2021.
//

import Foundation

protocol WalletListViewInput: AnyObject {
    
    func reloadUI()
}

protocol WalletListViewOutput: AnyObject {
    
    func viewDidLoad()
    
    func viewWillAppear()
    
    func buttonAddTapped()
    
    func didSelectRowAt(index: Int)
    
    func numberOfItems() -> Int
    
    func modelOfIndex(index: Int) -> Wallet
}



//
//  TransactionHistoryProtocols.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 23.10.2021.
//

import Foundation

protocol TransactionHistoryViewInput: AnyObject {
    
    func reloadUI()
}

protocol TransactionHistoryViewOutput: AnyObject {
    
    func viewDidLoad()
    
    func viewWillAppear()
    
    func buttonBackTapped()
    
    func didSelectRowAt(index: Int)
    
    func numberOfItems() -> Int
    
    func modelOfIndex(index: Int) -> Transaction
    
    func currentModel() -> Wallet
}




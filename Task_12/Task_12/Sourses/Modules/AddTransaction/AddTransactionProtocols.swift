//
//  AddTransactionProtocols.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 23.10.2021.
//

import Foundation

protocol TextInputCollectionViewCellDelegate {
    
    func getData (data: String, index: Int)
    
    func dataTransfer(index: Int)
}

protocol AddTransactionViewInput: AnyObject {
    
    func reloadUI()
}

protocol AddTransactionViewOutput: AnyObject {
    
    func viewDidLoad()
    
    func viewWillAppear()
    
    func currentUserWallet () -> Wallet
    
    func currentModel() -> Transaction
    
    func segmentControlTapped()
    
    func addTitle(title: String)

    func addChange(change: Double)

    func addNote(note: String)
    
    func buttonBackTapped(wallet: Wallet)
    
    func buttonSaveTapped(wallet: Wallet)
    
    func didSelectRowAt()
    
    func currentLabel() -> String
    
    func numberOfItems() -> Int
}

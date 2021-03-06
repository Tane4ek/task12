//
//  AddWalletProtocols.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 18.10.2021.
//

import Foundation

protocol TextFieldButtonCollectionViewCellDelegate {
   
    func getData (data: String)
}

protocol AddWalletViewInput: AnyObject {
    
    func reloadUI()
}

protocol AddWalletViewOutput: AnyObject {
    
    func viewDidLoad()
    
    func viewWillAppear()
    
    func buttonSaveTapped()
    
    func buttonDeleteTapped()
    
    func addData(data: String)
    
    func buttonBackTapped()
    
    func showCurrencyModule()
    
    func showCurrentColorModule()
    
    func currentLabel() -> String
    
    func currentModel() -> Wallet
    
    func numberOfItems() -> Int
}

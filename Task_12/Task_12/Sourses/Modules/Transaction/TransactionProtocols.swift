//
//  TransactionProtocols.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 11.11.2021.
//

import Foundation

protocol TransactionViewInput: AnyObject {
    
    func reloadUI()
}

protocol TransactionViewOutput: AnyObject {
    
    func viewDidLoad()
    
    func viewWillAppear()
    
    func currentModel() -> Transaction
    
    func buttonBackTapped()
    
    func buttonDeleteTapped()
    
    func buttonEditTapped()
    
    func numberOfItems() -> Int 
}

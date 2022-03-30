//
//  CurrenciesListProtocols.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 05.11.2021.
//

import Foundation

protocol CurrenciesListModuleOutput: AnyObject {
   
    func chooseCurrency(currency: Currency)
}

protocol CurrenciesListViewInput: AnyObject {
    
    func reloadUI()
}

protocol CurrenciesListViewOutput: AnyObject {
    
    func viewDidLoad()
    
    func viewWillAppear()
    
    func buttonBackTapped()
    
    func didSelectRowAt(index: Int) -> Currency
    
    func numberOfItems() -> Int
    
    func modelOfIndex(index: Int) -> Currency
    
    func currentColor() -> String
}



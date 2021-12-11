//
//  CurrentColorProtocols.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.11.2021.
//

import Foundation

protocol CurrentColorModuleOutput: AnyObject {
    func chooseColor(color: Color)
}

protocol CurrentColorViewInput: AnyObject {
    
    func reloadUI()
}

protocol CurrentColorViewOutput: AnyObject {
    
    func viewDidLoad()
    
    func viewWillAppear()
    
    func buttonBackTapped()
    
    func didSelectRowAt(index: Int) -> Color
    
    func numberOfItems() -> Int
    
    func modelOfIndex(index: Int) -> Color
    
    func currentColor() -> String
}

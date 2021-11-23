//
//  CurrentColorPresenter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.11.2021.
//

import Foundation

class CurrentColorPresenter {
    
    weak var view: CurrentColorViewInput?
    var models: [Color] = []
    var router: CurrentColorRouter?
    var colorServise: ColorService?
    
    weak var output: CurrentColorModuleOutput?
//    var newWallet: Wallet?
//
//    var walletService: WalletService?
//    var wallet: Wallet?
    

}

extension CurrentColorPresenter: CurrentColorViewOutput {
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        models = colorServise?.color() ?? []
        view?.reloadUI()
    }
    
    func buttonBackTapped() {
        router?.backToAddWalletModule()
    }
    
    func didSelectRowAt(index: Int) -> Color {
        
        let currentColor = models[index]
        output?.chooseColor(color: currentColor)

        router?.backToAddWalletModule()
        return currentColor
    }
    
    func numberOfItems() -> Int {
        return models.count
    }
    
    func modelOfIndex(index: Int) -> Color {
        let currentColor = models[index]
        return currentColor
    }
}

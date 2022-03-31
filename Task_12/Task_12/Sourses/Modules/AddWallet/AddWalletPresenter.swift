//
//  AddWalletPresenter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 18.10.2021.
//

import Foundation

class AddWalletPresenter {
    
    weak var view: AddWalletViewInput?
    var router: AddWalletRouter?
    var walletServise: WalletService?
    var currency: Currency?
    
    weak var output: CurrenciesListModuleOutput?
    
    var wallet: Wallet
    let isEditMode: Bool
    
    init(wallet: Wallet?){
        self.isEditMode = wallet != nil
        self.wallet = wallet ?? Wallet(id: UUID(), name: "", balance: 0, dateOfLastChange: Date.now, codeCurrency: "", colorName: "Celadon")
    }
}

extension AddWalletPresenter: AddWalletViewOutput {
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        view?.reloadUI()
    }
    
    func addData(data: String) {
        wallet.name = data
        print("изменяем кошелек", wallet)
    }
    
    func buttonSaveTapped() {
        if wallet.name.isEmpty {
//            если имя пустое
            router?.showAlert()
            return
        }
        let result = walletServise?.updateWalletIfCan(wallet: wallet)
        if result == true {
            router?.returnToWalletModule()
        } else {
            router?.showAlertSameWallet()
        }
    }
    
    func showCurrencyModule() {
        router?.showCurrencyModule(output: self, color: wallet.colorName)
    }
    
    func showCurrentColorModule() {
        router?.showCurrentColorModule(output: self, color: wallet.colorName)
    }
    
    func buttonBackTapped() {
        router?.returnToWalletModule()
    }
    
    func buttonDeleteTapped() {
        walletServise?.deleteWallet(walletID: wallet.id)
        router?.returnToWalletListModule()
    }
    
    func currentLabel() -> String {
        isEditMode ? "Edit wallet" : "Add new Wallet"
    }
    
    func currentModel() -> Wallet {
        return wallet
    }
    
    func numberOfItems() -> Int {
        return 1
    }
}

extension AddWalletPresenter: CurrenciesListModuleOutput {
    func chooseCurrency(currency: Currency) {
        wallet.codeCurrency = currency.symbol
    }
}

extension AddWalletPresenter: CurrentColorModuleOutput {
    func chooseColor(color: Color) {
        wallet.colorName = color.name
    }
}

//
//  AddWalletPresenter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 18.10.2021.
//

import Foundation

class AddWalletPresenter {
    
    weak var view: AddWalletViewInput?
    var newWallet: Wallet?
    var router: AddWalletRouter?
    var walletServise: WalletService?
    var currency: Currency?
    
    weak var output: CurrenciesListModuleOutput?
    
    var wallet: Wallet?
    init(wallet: Wallet?){
        self.wallet = wallet
    }
}

extension AddWalletPresenter: AddWalletViewOutput {
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        view?.reloadUI()
    }
    
    func addData(data: String) {
        if  wallet == nil && (newWallet == nil || newWallet?.codeCurrency == "") {
            newWallet = Wallet(id: UUID(), name: data, balance: 0, dateOfLastChange: Date.now, codeCurrency: "", colorName: "")
            print("если валюта НЕ выбрана", newWallet)
        } else if newWallet?.codeCurrency != "" && wallet == nil {
            newWallet?.name = data
            print("если валюта выбрана", newWallet)
        } else if wallet != nil{
            wallet?.name = data
            print("изменяем кошелек", wallet)
        }
    }
    
    func addCurrency(currency: String) {
        newWallet?.codeCurrency = currency
    }
    
    
    
    func buttonSaveTapped() {
//        если зашли в создание кошелька и сразу нажали на save
        if newWallet == nil && wallet == nil {
            router?.showAlert()
//            если выбрали валюту, но не дали имя кошельку
        } else if newWallet?.name == "" && wallet == nil {
            router?.showAlert()
//            если удалили в окне редактирования имя кошелька
        } else if wallet?.name == "" {
            router?.showAlert()
        }
        walletServise?.wallets().forEach({
            if $0.name == newWallet?.name {
                router?.showAlertSameWallet()
                newWallet = nil
            }
        })
        if wallet == nil && newWallet?.name != "" {
        guard let newUserWallet = newWallet else {return}
        walletServise?.addNewWallet(wallet: newUserWallet)
            print(WalletServiceImpl().wallets())
        } else if wallet != nil {
            walletServise?.updadeWalletName(walletID: wallet!.id, name: wallet!.name)
        }
        router?.returnToWalletModule()
    }
    
    func showCurrencyModule() {
        router?.showCurrencyModule(output: self)
    }
    
    func showCurrentColorModule() {
        router?.showCurrentColorModule(output: self)
    }
    
    func buttonBackTapped() {
        router?.returnToWalletListModule()
    }
    
    func buttonDeleteTapped() {
        walletServise?.deleteWallet(walletID: wallet!.id)
        router?.returnToWalletListModule()
    }
    
    func currentLabel() -> String {
        var currentLabel = ""
        if wallet == nil {
            currentLabel = "Add new Wallet"
        } else {
            currentLabel = "Edit wallet"
        }
        return currentLabel
    }
    
    func currentModel() -> Wallet {
        var currentWallet: Wallet?
        if wallet != nil {
            currentWallet = wallet
        } else if newWallet != nil {
            currentWallet = newWallet
        } else {
            currentWallet = Wallet(id: UUID(), name: "", balance: 0, dateOfLastChange: Date.now, codeCurrency: "", colorName: "Celadon")
        }
        return currentWallet!
    }
    
    func numberOfItems() -> Int {
        return 1
    }
}

extension AddWalletPresenter: CurrenciesListModuleOutput {
    func chooseCurrency(currency: Currency) {
        if wallet != nil {
            wallet?.codeCurrency = currency.symbol
            walletServise?.updateWalletCurrency(walletID: wallet!.id, currentCode: currency.symbol)
            print("изменили валюту кошелька", wallet)
        } else if wallet == nil && newWallet != nil {
            newWallet?.codeCurrency = currency.symbol
            print("если имя не записано", newWallet)
        } else if newWallet == nil {
            newWallet = Wallet(id: UUID(), name: "", balance: 0, dateOfLastChange: Date.now, codeCurrency: currency.symbol, colorName: "Celadon")
            print("если имя есть", newWallet)
        }
    }
}

extension AddWalletPresenter: CurrentColorModuleOutput {
    func chooseColor(color: Color) {
        if wallet != nil {
            wallet?.colorName = color.name
            walletServise?.updateWalletColor(walletID: wallet!.id, colorName: color.name)
            print("изменили валюту кошелька", wallet)
        } else if wallet == nil && newWallet != nil {
            newWallet?.colorName = color.name
            print("если имя не записано", newWallet)
        } else if newWallet == nil {
            newWallet = Wallet(id: UUID(), name: "", balance: 0, dateOfLastChange: Date.now, codeCurrency: "", colorName: color.name)
            print("если имя есть", newWallet)
        }
    }
}

//
//  WalletRouter.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 21.10.2021.
//

import UIKit

class WalletRouter {
    
    weak var view: UIViewController?
    var serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func returnToWalletListModule() {
        view?.navigationController?.popViewController(animated: true)
//        view?.dismiss(animated: true, completion: nil)
    }
    
//    func showWalletListModule() {
//        view?.dismiss(animated: true, completion: nil)
//    }
    
    func showAddTransactionModule(currentWallet: Wallet, currentTransaction: Transaction?) {
        let configurator = AddTransactionModuleConfigurator(serviceContainer: serviceContainer)
        let addTransactionViewController = configurator.configure(currentWallet: currentWallet, currentTransaction: currentTransaction)
//        addTransactionViewController.modalPresentationStyle = .fullScreen
//        view?.present(addTransactionViewController, animated: true, completion: nil)
        view?.navigationController?.pushViewController(addTransactionViewController, animated: true)
    }
    
    func showTransactionHistoryModule(currentWallet: Wallet) {
        let configurator = TransactionHistoryModuleConfigurator(serviceContainer: serviceContainer)
        let transactionHistoryViewController = configurator.configure(currentWallet: currentWallet)
//        transactionHistoryViewController.modalPresentationStyle = .fullScreen
//        view?.present(transactionHistoryViewController, animated: true, completion: nil)
        view?.navigationController?.pushViewController(transactionHistoryViewController, animated: true)
    }
    
    func showEditWallet(wallet: Wallet) {
        let configurator = AddWalletModuleConfigurator(serviceContainer: serviceContainer)
        let addWalletViewController = configurator.configure(wallet: wallet)
//        addWalletViewController.modalPresentationStyle = .fullScreen
//        view?.present(addWalletViewController, animated: true, completion: nil)
        view?.navigationController?.pushViewController(addWalletViewController, animated: true)
    }
    
    func showTransactionModule(wallet: Wallet, transaction: Transaction) {
        let configurator = TransactionModuleConfigurator(serviceContainer: serviceContainer)
        let transactionViewController = configurator.configure(wallet: wallet, model: transaction)
//        transactionViewController.modalPresentationStyle = .fullScreen
//        view?.present(transactionViewController, animated: true, completion: nil)
        view?.navigationController?.pushViewController(transactionViewController, animated: true)
    }
    
}

//
//  ServiceContainer .swift
//  Task_12
//
//  Created by Татьяна Лузанова on 15.10.2021.
//

import Foundation

struct ServiceContainer {
    
    let walletService: WalletService
    let transactionService: TransactionService
    let currencyService: CurrencyService
    let colorService: ColorService
}

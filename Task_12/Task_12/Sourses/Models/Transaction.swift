//
//  Transactions.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 12.10.2021.
//

import Foundation

// TODO: Переименовать в Transaction
// TODO: добавить поле id типа UUID
struct Transaction {
    let id: UUID
    var title: String
    var change: Double
    var date: Date
    var note: String
    var codeCurrency: String
    var colorName: String
}

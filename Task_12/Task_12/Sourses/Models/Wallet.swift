//
//  File.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 12.10.2021.
//

import Foundation

// TODO: добавить поле id типа UUID
// TODO: balance может быть дробным
// TODO: дату лучше хранить в типе Date
// TODO: добавить типа валюты
struct Wallet {
    let id: UUID
    var name: String
    var balance: Double
    let dateOfLastChange: Date
    var codeCurrency: String
    var colorName: String
}

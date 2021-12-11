//
//  Wallets+CoreDataProperties.swift
//  Task_12
//
//  Created by Поздняков Игорь Николаевич on 11.12.2021.
//
//

import Foundation
import CoreData


extension Wallets {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wallets> {
        return NSFetchRequest<Wallets>(entityName: "Wallets")
    }

    @NSManaged public var balance: Double
    @NSManaged public var colorName: String?
    @NSManaged public var codeCurrency: String?
    @NSManaged public var dateOfLastChange: Date?
    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var myTransactions: NSSet?

}

// MARK: Generated accessors for myTransactions
extension Wallets {

    @objc(addMyTransactionsObject:)
    @NSManaged public func addToMyTransactions(_ value: Transactions)

    @objc(removeMyTransactionsObject:)
    @NSManaged public func removeFromMyTransactions(_ value: Transactions)

    @objc(addMyTransactions:)
    @NSManaged public func addToMyTransactions(_ values: NSSet)

    @objc(removeMyTransactions:)
    @NSManaged public func removeFromMyTransactions(_ values: NSSet)

}

extension Wallets : Identifiable {

}

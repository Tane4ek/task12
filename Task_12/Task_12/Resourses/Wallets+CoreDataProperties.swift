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

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var balance: Double
    @NSManaged public var dateOfLastChange: Date?
    @NSManaged public var colorName: String?
    @NSManaged public var codeCurrency: String?
    @NSManaged public var myTransaction: NSSet?

}

// MARK: Generated accessors for myTransaction
extension Wallets {

    @objc(addMyTransactionObject:)
    @NSManaged public func addToMyTransaction(_ value: Transactions)

    @objc(removeMyTransactionObject:)
    @NSManaged public func removeFromMyTransaction(_ value: Transactions)

    @objc(addMyTransaction:)
    @NSManaged public func addToMyTransaction(_ values: NSSet)

    @objc(removeMyTransaction:)
    @NSManaged public func removeFromMyTransaction(_ values: NSSet)

}

extension Wallets : Identifiable {

}

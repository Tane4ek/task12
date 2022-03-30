//
//  Wallets+CoreDataProperties.swift
//  Task_12
//
//  Created by Tatiana Luzanova on 30.03.2022.
//
//

import Foundation
import CoreData


extension Wallets {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wallets> {
        return NSFetchRequest<Wallets>(entityName: "Wallets")
    }

    @NSManaged public var balance: Double
    @NSManaged public var codeCurrency: String?
    @NSManaged public var colorName: String?
    @NSManaged public var dateOfLastChange: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var myTransaction: Transactions?

}

extension Wallets : Identifiable {

}

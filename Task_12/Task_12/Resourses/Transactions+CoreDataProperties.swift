//
//  Transactions+CoreDataProperties.swift
//  Task_12
//
//  Created by Tatiana Luzanova on 30.03.2022.
//
//

import Foundation
import CoreData


extension Transactions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transactions> {
        return NSFetchRequest<Transactions>(entityName: "Transactions")
    }

    @NSManaged public var change: Double
    @NSManaged public var codeCurrency: String?
    @NSManaged public var colorName: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var note: String?
    @NSManaged public var title: String?
    @NSManaged public var fromwallet: Wallets?

}

extension Transactions : Identifiable {

}

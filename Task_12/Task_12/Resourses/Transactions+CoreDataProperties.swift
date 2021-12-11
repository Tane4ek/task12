//
//  Transactions+CoreDataProperties.swift
//  Task_12
//
//  Created by Поздняков Игорь Николаевич on 11.12.2021.
//
//

import Foundation
import CoreData


extension Transactions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transactions> {
        return NSFetchRequest<Transactions>(entityName: "Transactions")
    }

    @NSManaged public var colorName: String?
    @NSManaged public var codeCurrency: String?
    @NSManaged public var date: Double
    @NSManaged public var note: String?
    @NSManaged public var change: Double
    @NSManaged public var title: String?
    @NSManaged public var id: UUID?
    @NSManaged public var fromWallet: Wallets?

}

extension Transactions : Identifiable {

}

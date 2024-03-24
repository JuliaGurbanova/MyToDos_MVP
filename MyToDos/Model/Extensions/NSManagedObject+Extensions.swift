//
//  NSManagedObject+Extensions.swift
//  MyToDos
//
//  Created by Julia Gurbanova on 05.03.2024.
//

import Foundation
import CoreData

public extension NSManagedObject {
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}

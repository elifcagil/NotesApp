//
//  Note+CoreDataProperties.swift
//  NotesApp
//
//  Created by ELİF ÇAĞIL on 17.04.2025.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: UUID?
    @NSManaged public var content: String?
    @NSManaged public var timestamp: Date?

}

extension Note : Identifiable {

}

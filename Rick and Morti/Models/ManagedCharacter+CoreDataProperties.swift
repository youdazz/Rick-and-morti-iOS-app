//
//  ManagedCharacter+CoreDataProperties.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 9/2/23.
//
//

import Foundation
import CoreData


extension ManagedCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedCharacter> {
        return NSFetchRequest<ManagedCharacter>(entityName: "ManagedCharacter")
    }

    @NSManaged public var created: String?
    @NSManaged public var url: String?
    @NSManaged public var episodes: NSObject?
    @NSManaged public var image: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var status: String?
    @NSManaged public var type: String?
    @NSManaged public var gender: String?
    @NSManaged public var specie: String?
    @NSManaged public var locationName: String?
    @NSManaged public var locationUrl: String?
    @NSManaged public var originName: String?
    @NSManaged public var originUrl: String?

}

extension ManagedCharacter : Identifiable {

}

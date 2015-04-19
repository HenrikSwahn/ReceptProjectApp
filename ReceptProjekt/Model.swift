//
//  Model.swift
//  ReceptApplikation
//
//  Created by Henrik Swahn on 2014-09-21.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit
import CoreData


//Model to tell core data to handle the information, is connected with Recipe entity in the datamodel
@objc(Model)
class Model: NSManagedObject
{
    @NSManaged var category: String
    @NSManaged var desc: String
    @NSManaged var id: String
    @NSManaged var imageURL: String
    @NSManaged var name: String
    @NSManaged var time: String
    
    func toString() ->String
    {
        return "\(name)     \(category)";
    }
}

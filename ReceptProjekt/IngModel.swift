//
//  IngModel.swift
//  ReceptApplikation
//
//  Created by Henrik Swahn on 2014-09-29.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit
import CoreData


//Model to tell core data to handle the information, is connected with Ingredients entity in the datamodel
@objc(IngModel)
class IngModel: NSManagedObject
{
    @NSManaged var id: String
    @NSManaged var name: String
    
    func toString() ->String
    {
        return "\(id) + \(name)";
    }
}

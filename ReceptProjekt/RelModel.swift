//
//  RelModel.swift
//  ReceptApplikation
//
//  Created by Henrik Swahn on 2014-09-29.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//
import UIKit
import CoreData


//Model to tell core data to handle the information, is connected with Relations entity in the datamodel
@objc(RelModel)
class RelModel: NSManagedObject
{
    @NSManaged var fkRecipe: String
    @NSManaged var fkIngredient: String
    @NSManaged var amount: String
    @NSManaged var unit: String
    
    
    func toString() ->String
    {
        return "\(fkRecipe) + \(fkIngredient) + \(amount) + \(unit)";
    }
}

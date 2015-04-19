//
//  ShopListModel.swift
//  ReceptApplikation
//
//  Created by Henrik Swahn on 2014-10-09.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//
import UIKit
import CoreData


//Model to tell core data to handle the information, is connected with Shoppinglist entity in the datamodel
@objc(ShopListModel)
class ShopListModel: NSManagedObject
{
    @NSManaged var name: String
    @NSManaged var amount: Float
    @NSManaged var unit: String
}
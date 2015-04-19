//
//  ShoppingListClass.swift
//  RecipeApplicationV2
//
//  Created by Henrik Swahn on 2014-10-11.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import Foundation




//CLass to hold basic structure and functions of the shoppingList
class ShoppingListClass
{
    private var name: String;
    private var amount: Float;
    private var unit: String;
    
    init(name: String, amount: Float, unit: String)
    {
        self.name = name;
        self.amount = amount;
        self.unit = unit;
    }
    
    //Getters
    func getName() ->String
    {
        return self.name;
    }
    func getAmount() ->Float
    {
        return self.amount;
    }
    func getUnit() ->String
    {
        return self.unit;
    }
    
    //Setters
    func addToAmount(amount: Float)
    {
        self.amount += amount;
    }
}
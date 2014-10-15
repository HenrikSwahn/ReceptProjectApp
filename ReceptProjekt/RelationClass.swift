//
//  RelationClass.swift
//  RecipeApplicationV2
//
//  Created by Henrik Swahn on 2014-10-11.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import Foundation




//Class to hold basic structe and functions of the relations between recipes and the ingredients
class RelationClass
{
    private var FkRecipe: String;
    private var FkIngredient: String;
    private var amount: String;
    private var unit: String;

    init(FkRecipe: String, FkIngredient: String, amount: String, unit: String)
    {
        self.FkRecipe = FkRecipe;
        self.FkIngredient = FkIngredient;
        self.amount = amount;
        self.unit = unit;
    }
    
    //Getters
    func getFkRecipe() ->String
    {
        return self.FkRecipe;
    }
    func getFkIngredient() ->String
    {
        return self.FkIngredient;
    }
    func getAmount() ->String
    {
        return self.amount;
    }
    func getUnit() ->String
    {
        return self.unit;
    }
}
//
//  IngredientClass.swift
//  RecipeApplicationV2
//
//  Created by Henrik Swahn on 2014-10-11.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import Foundation


//Class to hold basic structure and functionality for ingredients
class IngredientClass
{
    private var id: String;
    private var name: String;
    
    init(id: String, name: String)
    {
        self.id = id;
        self.name = name;
    }
    
    //Getters
    func getId() ->String
    {
        return self.id;
    }
    func getName() ->String
    {
        return self.name;
    }
}
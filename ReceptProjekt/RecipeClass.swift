//
//  RecipeClass.swift
//  RecipeApplicationV2
//
//  Created by Henrik Swahn on 2014-10-11.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import Foundation



//Class to hold basic structure and functionality of Recipes
class RecipeClass
{
    private var id: String;
    private var name: String;
    private var category: String;
    private var desc: String;
    private var time: String;
    private var URL: String;
    
    init(id: String, name: String, category: String, desc: String, time: String, URL: String)
    {
        self.id = id;
        self.name = name;
        self.category = category;
        self.desc = desc;
        self.time = time;
        self.URL = URL;
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
    func getCategory() ->String
    {
        return self.category;
    }
    func getDesc() ->String
    {
        return self.desc;
    }
    func getTime() ->String
    {
        return self.time;
    }
    func getURL() ->String
    {
        return self.URL;
    }
    func getTimeAsInt() ->Int
    {
        return self.time.toInt()!;
    }
}
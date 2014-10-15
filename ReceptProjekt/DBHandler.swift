//
//  DBHandler.swift
//  ReceptApplikation
//
//  Created by Henrik Swahn on 2014-09-21.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit
import CoreData

class DBHandler: NSObject
{
    private var reciArray = [RecipeClass]();
    private var ingrArray = [IngredientClass]();
    private var relArray = [RelationClass]();
    
    
    //Recipes
    func addRecipes()
    {
        var conn: MySQLConnection = MySQLConnection();
        conn.retriveRecipes();

        //Fetches the recipes from the conn var and append to reciArray
        for(var i = 0 as Int32; i < conn.getSize(); i++)
        {
            var temp = RecipeClass(
                id:conn.getID(i),
                name:conn.getName(i),
                category:conn.getCategory(i),
                desc:conn.getDesc(i),
                time:conn.getTime(i),
                URL:conn.getURL(i));
            reciArray.append(temp);
        }
        insertRecipesIntoDB();
    }
    private func insertRecipesIntoDB() //Inserts recipes from reciArr into the internal database
    {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        let context: NSManagedObjectContext = appDel.managedObjectContext!;
        let ent = NSEntityDescription.entityForName("Recipes", inManagedObjectContext: context)!;
        let request = NSFetchRequest(entityName: "Recipes");
        var result:NSArray = context.executeFetchRequest(request, error:nil)!;
        
        if(reciArray.count < result.count) //More recipes in internal than external database
        {
            println("More recipes in local database than external");
            emptyEntity("Recipes");
            for(var i = 0; i < reciArray.count; i++)
            {
                var newRecipe = Model(entity: ent, insertIntoManagedObjectContext: context);
                newRecipe.id = reciArray[i].getId();
                newRecipe.name = reciArray[i].getName();
                newRecipe.category = reciArray[i].getCategory();
                newRecipe.desc = reciArray[i].getDesc();
                newRecipe.time = reciArray[i].getTime();
                newRecipe.imageURL = reciArray[i].getURL();
                context.save(nil);
            }
        }
        else if(reciArray.count > result.count) //More recipes in external than internal database
        {
            println("More recipes in external than local database");
            for(var i = 0; i < reciArray.count; i++)
            {
                var hit = false;
                for(var j = 0; j < result.count && hit == false; j++)
                {
                    var temp = result.objectAtIndex(j) as Model;
                    if(reciArray[i].getId() == temp.id)
                    {
                        hit = true; //Recipe id already exsist in the core data
                    }
                }
                if(hit == false)
                {
                    var newRecipe = Model(entity: ent, insertIntoManagedObjectContext: context);
                    newRecipe.id = reciArray[i].getId();
                    newRecipe.name = reciArray[i].getName();
                    newRecipe.category = reciArray[i].getCategory();
                    newRecipe.desc = reciArray[i].getDesc();
                    newRecipe.time = reciArray[i].getTime();
                    newRecipe.imageURL = reciArray[i].getURL();
                    context.save(nil);
                }
            }
        }
        else //Same amount of recipes in internal and external
        {
            println("same number of recipes");
        }
        toConsol("Recipes");
    }
    
    //Ingredients
    func addIngredients()
    {
        var conn: MySQLConnection = MySQLConnection();
        conn.retriveIngredients();
        
        //Fetches the ingredients from the conn var and append to ingrArray
        for(var i = 0 as Int32; i < conn.getIngredientSize(); i++)
        {
            var temp = IngredientClass(id: conn.getIngredientsID(i), name: conn.getIngredientsName(i));
            ingrArray.append(temp);
        }
        inserIngredientsIntoDB();
    }
    private func inserIngredientsIntoDB() //Inserts ingredients from ingrArray into the internal database
    {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        let context:NSManagedObjectContext = appDel.managedObjectContext!;
        let ent = NSEntityDescription.entityForName("Ingredients", inManagedObjectContext: context);
        let request = NSFetchRequest(entityName: "Ingredients")
        var result:NSArray = context.executeFetchRequest(request, error: nil)!;
        
        if(ingrArray.count < result.count) //More ingredients in the internal than external database
        {
            println("More ingredients in local database than external");
            emptyEntity("Ingredients");
            for(var i = 0; i < ingrArray.count; i++)
            {
                var newIngredient = IngModel(entity: ent!, insertIntoManagedObjectContext: context);
                newIngredient.id = ingrArray[i].getId();
                newIngredient.name = ingrArray[i].getName();
                context.save(nil);
            }
        }
        else if(ingrArray.count > result.count) //More recipes in the external than the internal database
        {
            println("More ingredients in external than local database");
            for(var i = 0; i < ingrArray.count; i++)
            {
                var hit = false;
                for(var j = 0; j < result.count && hit == false; j++)
                {
                    let temp = result.objectAtIndex(j) as IngModel;
                    if(ingrArray[i].getId() == temp.id)
                    {
                        hit = true;
                    }
                }
                if(hit == false)
                {
                    var newIngredient = IngModel(entity: ent!, insertIntoManagedObjectContext: context);
                    newIngredient.id = ingrArray[i].getId();
                    newIngredient.name = ingrArray[i].getName();
                    context.save(nil);
                }
            }
        }
        else //Same amount of ingredients in internal and external database
        {
            println("Same amount of ingredients");
        }
        
        toConsol("Ingredients");
    }
    
    //Relations
    func addRelations()
    {
        var conn: MySQLConnection = MySQLConnection();
        conn.retriveRelations();
        
        //Fetches the relations from the conn var and append to relArray
        for(var i = 0 as Int32; i < conn.getRelationsSize(); i++)
        {
            var temp = RelationClass(
                FkRecipe: conn.getFkRecipe(i),
                FkIngredient: conn.getFkIngredient(i),
                amount: conn.getAmount(i),
                unit: conn.getUnit(i));
            relArray.append(temp);
        }
        insertRelationsIntoDB();
    }
    private func insertRelationsIntoDB() //Inserts the relations from the relArray into the internal database
    {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        let context:NSManagedObjectContext = appDel.managedObjectContext!;
        let ent = NSEntityDescription.entityForName("Relations", inManagedObjectContext: context);
        let request = NSFetchRequest(entityName: "Relations");
        var result:NSArray = context.executeFetchRequest(request, error: nil)!;

        if(relArray.count < result.count) //More relations in internal than external database
        {
            println("More relations in local database than in external");
            emptyEntity("Relations");
            for(var i = 0; i < relArray.count; i++)
            {
                var newRelation = RelModel(entity: ent!, insertIntoManagedObjectContext: context);
                newRelation.fkRecipe = relArray[i].getFkRecipe();
                newRelation.fkIngredient = relArray[i].getFkIngredient();
                newRelation.amount = relArray[i].getAmount();
                newRelation.unit = relArray[i].getUnit();
                context.save(nil);
            }
        }
        else if(relArray.count > result.count) //More relations in the external than the internal database
        {
            println("More relations in external than local database");
            for(var i = 0; i < relArray.count; i++)
            {
                var hit = false;
                for(var j = 0; j < result.count && hit == false; j++)
                {
                    let temp = result.objectAtIndex(j) as RelModel;
                    if(relArray[i].getFkRecipe() == temp.fkRecipe)
                    {
                        if(relArray[i].getFkIngredient() == temp.fkIngredient)
                        {
                            hit = true;
                        }
                    }
                }
                if(hit == false)
                {
                    var newRelation = RelModel(entity: ent!, insertIntoManagedObjectContext: context);
                    newRelation.fkRecipe = relArray[i].getFkRecipe();
                    newRelation.fkIngredient = relArray[i].getFkIngredient();
                    newRelation.amount = relArray[i].getAmount();
                    newRelation.unit = relArray[i].getUnit();
                    context.save(nil);
                }
            }
        }
        else //Same amount of relations in internal and external database
        {
            println("Same amount of relations");
        }
        toConsol("Relations");
    }
    
    //ShoppingList
    //Inserts the current shoppinglist into internaldatabase
    func insertShoppingListIntoDB(shoppingList:[ShoppingListClass])
    {
        emptyEntity("ShoppingList");
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        let context:NSManagedObjectContext = appDel.managedObjectContext!;
        let ent = NSEntityDescription.entityForName("ShoppingList", inManagedObjectContext: context);
        
        for(var i = 0; i < shoppingList.count;i++)
        {
            var newShoppingList = ShopListModel(entity: ent!, insertIntoManagedObjectContext: context);
            newShoppingList.name = shoppingList[i].getName();
            newShoppingList.amount = shoppingList[i].getAmount();
            newShoppingList.unit = shoppingList[i].getUnit();
            context.save(nil);
        }
    }
    
    //Remove everything from the chosen entity
    func emptyEntity(Entity: String)
    {
        println("Dropped");
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        let context: NSManagedObjectContext = appDel.managedObjectContext!;
        let ent = NSEntityDescription.entityForName(Entity, inManagedObjectContext: context)!;
        let request = NSFetchRequest(entityName:  Entity);
        
        var result:NSArray = context.executeFetchRequest(request, error:nil)!;
        
        println(result.count);
        
        for(var i = 0; i < result.count; i++)
        {
            context.deleteObject(result.objectAtIndex(i)as NSManagedObject);
        }
        context.save(nil);
    }
    
    //Return a NSArray with the result from the query
    func getEntity(Entity: String,filter: String,Predicate: String) ->NSArray
    {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        let context: NSManagedObjectContext = appDel.managedObjectContext!;
        let ent = NSEntityDescription.entityForName(Entity, inManagedObjectContext: context)!;
        let request = NSFetchRequest(entityName: Entity);
        
        if(Predicate != "All")
        {
            request.predicate = NSPredicate(format: "\(filter) = %@", Predicate);
        }
        var result:NSArray = context.executeFetchRequest(request, error:nil)!;
        return result;
    }
    
    //Writes a entity to the console
    private func toConsol(Entity: String)
    {
        var result:NSArray = getEntity(Entity, filter: "All", Predicate: "All");
        
        for res in result
        {
            if(Entity == "Recipes")
            {
                var thisRes = res as Model;
                println(thisRes.toString());
            }
            else if(Entity == "Ingredients")
            {
                var thisRes = res as IngModel;
                println(thisRes.toString());
            }
            else if(Entity == "Relations")
            {
                var thisRes = res as RelModel;
                println(thisRes.toString());
            }
        }
    }
}

//
//  MySQLConnection.m
//  ReceptApplikation
//
//  Created by Henrik Swahn on 2014-09-21.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

#import "MySQLConnection.h"

@implementation MySQLConnection
@synthesize jsonArray,recipesIDArray,recipesCategoryArray,recipesNameArray,recipesDescArray,recipesTimeArray,recipesURLArray;
@synthesize jsonIngredientsArray,ingredientsIdArray,ingredientsNameArray;
@synthesize jsonRelationsArray,FkIngredientArray,FkRecipeArray,amountArray,unitArray;
@synthesize mySqlCheck,webServerCheck;


//Retrive recipes from the external database
-(void)retriveRecipes
{
    NSURL * url = [NSURL URLWithString: @"http://localhost/App/iOS/iOSConnection.php"];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    if(data != nil) //Connected to webserver
    {
        jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:Nil];
        
        if(jsonArray != nil) //Connected to MySQL server
        {
            //Set up Recipes array
            recipesIDArray = [[NSMutableArray alloc] init];
            recipesNameArray = [[NSMutableArray alloc] init];
            recipesCategoryArray = [[NSMutableArray alloc] init];
            recipesDescArray = [[NSMutableArray alloc] init];
            recipesTimeArray = [[NSMutableArray alloc] init];
            recipesURLArray = [[NSMutableArray alloc] init];
    
            for(int i = 0; i < jsonArray.count; i++)
            {
                //Create recipe object
                NSString * rID = [[jsonArray objectAtIndex:i] objectForKey:@"id"];
                NSString * rName = [[jsonArray objectAtIndex:i] objectForKey:@"RName"];
                NSString * rCate = [[jsonArray objectAtIndex:i] objectForKey:@"RCategory"];
                NSString * rDesc = [[jsonArray objectAtIndex:i] objectForKey:@"RDesc"];
                NSString * rTime = [[jsonArray objectAtIndex:i] objectForKey:@"RTime"];
                NSString * rURL = [[jsonArray objectAtIndex:i] objectForKey:@"RImageURL"];
        
                [recipesIDArray addObject:rID];
                [recipesNameArray addObject:rName];
                [recipesCategoryArray addObject:rCate];
                [recipesDescArray addObject:rDesc];
                [recipesTimeArray addObject:rTime];
                [recipesURLArray addObject:rURL];
            }
            mySqlCheck = YES;
        }
        else //MySQL connection failed
        {
            mySqlCheck = NO;
        }
        webServerCheck = YES;
    }
    else //Webserver connection failed
    {
        webServerCheck = NO;
    }
}
//Retrive ingredients from the external database
-(void)retriveIngredients
{
    NSURL * url = [NSURL URLWithString:@"http://localhost/App/iOS/getIngredients.php"];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    if(data != nil) //Connected to Webserver
    {
        jsonIngredientsArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:Nil];

        if(jsonIngredientsArray != nil) //Connected to MySQL server
        {
            ingredientsIdArray = [[NSMutableArray alloc] init];
            ingredientsNameArray = [[NSMutableArray alloc] init];
    
            for(int i = 0; i < jsonIngredientsArray.count; i++)
            {
                NSString * goodsID = [[jsonIngredientsArray objectAtIndex:i] objectForKey:@"id"];
                NSString * goodsName = [[jsonIngredientsArray objectAtIndex:i] objectForKey:@"GName"];
                [ingredientsIdArray addObject:goodsID];
                [ingredientsNameArray addObject:goodsName];
            }
            mySqlCheck = YES;
        }
        else //MySQL connection failed
        {
            mySqlCheck = NO;
        }
        webServerCheck = YES;
    }
    else //Webser connection failed
    {
        webServerCheck = NO;
    }
}
//Retrive relations from the external database
-(void)retriveRelations
{
    NSURL *url = [NSURL URLWithString:@"http://localhost/App/iOS/getRelations.php"];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    if(data != nil) //Connected to webserver
    {
        jsonRelationsArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:Nil];

        if(jsonRelationsArray != nil) //Connected to MySQL server
        {
            FkRecipeArray = [[NSMutableArray alloc] init];
            FkIngredientArray = [[NSMutableArray alloc] init];
            amountArray = [[NSMutableArray alloc] init];
            unitArray = [[NSMutableArray alloc] init];
    
            for(int i = 0; i < jsonRelationsArray.count; i++)
            {
                NSString * FkRe = [[jsonRelationsArray objectAtIndex:i] objectForKey:@"FkRecipe"];
                NSString * FkIng = [[jsonRelationsArray objectAtIndex:i] objectForKey:@"FkIngredients"];
                NSString * amo = [[jsonRelationsArray objectAtIndex:i] objectForKey:@"amount"];
                NSString * uni = [[jsonRelationsArray objectAtIndex:i] objectForKey:@"unit"];
        
                [FkRecipeArray addObject:FkRe];
                [FkIngredientArray addObject:FkIng];
                [amountArray addObject:amo];
                [unitArray addObject:uni];
            }
            mySqlCheck = YES;
        }
        else //MySql connection failed
        {
            mySqlCheck = NO;
        }
        webServerCheck = YES;
    }
    else //Webser connection failed
    {
        webServerCheck = NO;
    }
}
//Getters for the recipes
-(NSString*)getID:(int)index
{
    return [recipesIDArray objectAtIndex:index];
}
-(NSString*)getName:(int)index
{
    return [recipesNameArray objectAtIndex:index];
}
-(NSString*)getCategory:(int)index
{
    return [recipesCategoryArray objectAtIndex:index];
}
-(NSString*)getDesc:(int)index
{
    return [recipesDescArray objectAtIndex:index];
}
-(NSString*)getTime:(int)index
{
    return [recipesTimeArray objectAtIndex:index];
}
-(NSString*)getURL:(int)index
{
    return [recipesURLArray objectAtIndex:index];
}
-(int)getSize
{
    return jsonArray.count;
}

//Getters for the Ingredients
-(NSString*)getIngredientsID:(int)index
{
    return [ingredientsIdArray objectAtIndex:index];
}
-(NSString*)getIngredientsName:(int)index
{
    return [ingredientsNameArray objectAtIndex:index];
}
-(int)getIngredientSize
{
    return jsonIngredientsArray.count;
}

//Getters for the relations
-(NSString*)getFkRecipe:(int)index
{
    return [FkRecipeArray objectAtIndex:index];
}
-(NSString*)getFkIngredient:(int)index
{
    return [FkIngredientArray objectAtIndex:index];
}
-(NSString*)getAmount:(int)index
{
    return [amountArray objectAtIndex:index];
}
-(NSString*)getUnit:(int)index
{
    return [unitArray objectAtIndex:index];
}
-(int)getRelationsSize
{
    return jsonRelationsArray.count;
}

//Error checks functions
-(BOOL)getMySqlCheck
{
    return mySqlCheck;
}
-(BOOL)getWebserverCheck
{
    return webServerCheck;
}


@end
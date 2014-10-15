//
//  MySQLConnection.h
//  ReceptApplikation
//
//  Created by Henrik Swahn on 2014-09-21.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface MySQLConnection : NSObject


//Recipes
@property (nonatomic, strong) NSMutableArray * jsonArray;
@property (nonatomic, strong) NSMutableArray * recipesIDArray;
@property (nonatomic, strong) NSMutableArray * recipesNameArray;
@property (nonatomic, strong) NSMutableArray * recipesCategoryArray;
@property (nonatomic, strong) NSMutableArray * recipesDescArray;
@property (nonatomic, strong) NSMutableArray * recipesTimeArray;
@property (nonatomic, strong) NSMutableArray * recipesURLArray;

-(void)retriveRecipes;
-(NSString*)getID:(int)index;
-(NSString*)getName:(int)index;
-(NSString*)getCategory:(int)index;
-(NSString*)getDesc:(int)index;
-(NSString*)getTime:(int)index;
-(NSString*)getURL:(int)index;
-(int)getSize;

//Ingredients
@property (nonatomic, strong) NSMutableArray * jsonIngredientsArray;
@property (nonatomic, strong) NSMutableArray * ingredientsIdArray;
@property (nonatomic, strong) NSMutableArray * ingredientsNameArray;


-(void)retriveIngredients;
-(NSString*)getIngredientsID:(int)index;
-(NSString*)getIngredientsName:(int)index;
-(int)getIngredientSize;

//Relations
@property (nonatomic, strong) NSMutableArray * jsonRelationsArray;
@property (nonatomic, strong) NSMutableArray * FkRecipeArray;
@property (nonatomic, strong) NSMutableArray * FkIngredientArray;
@property (nonatomic, strong) NSMutableArray * amountArray;
@property (nonatomic, strong) NSMutableArray * unitArray;

-(void)retriveRelations;
-(NSString*)getFkRecipe:(int)index;
-(NSString*)getFkIngredient:(int)index;
-(NSString*)getAmount:(int)index;
-(NSString*)getUnit:(int)index;
-(int)getRelationsSize;

@end
//
//  Resources.swift
//  ReceptApplikation
//
//  Created by Henrik Swahn on 2014-10-04.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

//Globals
var categoryArray = [String]();
var nrOfSections = 0;
var shoppingListArray = [ShoppingListClass]();
var DB:DBHandler = DBHandler();

//Custom Colors
let transparent:UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.0);
let white:UIColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.75);

//Fonts
let timesNewRoman15:UIFont = UIFont(name: "Times New Roman", size: 15);


//Strings
//AppDel
let recipeTabBarTitle = "Recept";
let searchTabBarTitle = "Sök";
let shoppingListTabBarTitle = "Inköpslista";
let mailTabBarTitle = "Dela";

//categorySelectionView
let categoryViewTitle = "Kategorier";

//RecipeTableViewController
let byNameButtonStr = "Efter namn";
let byTimeButtonStr = "Efter tid";

//RecipeDetailView
let rDVPortionButton = "Portioner";

let sizeX2Str = "2";
let sizeX4Str = "4";
let sizeX6Str = "6";
let sizeX8Str = "8";

let addAllStr = "Alla";
let addStr = "Enskild";


//SearchViewController
//Buttons
let nameButtonStr = "Recept namn";
let ingreButtonStr = "Ingredienser";

//SplitShoppingListViewCtr
//Buttons
let contBtnStr = "Fortsätt";
let rollbackBtnStr = "Återställ";

//AddViewController
let backButtonStr = "Tillbaka";


//Mail
var mailComposer:MFMailComposeViewController?;

func cycleTheGlobalMailComposer()
{
    mailComposer = nil;
    mailComposer = MFMailComposeViewController();
}

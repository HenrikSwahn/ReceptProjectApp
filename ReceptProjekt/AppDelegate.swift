//
//  AppDelegate.swift
//  ReceptProjekt
//
//  Created by Henrik Swahn on 2014-10-13.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?;
    var tabBar: UITabBarController?;
    var recipeNavController:UINavigationController?;
    var searchNavController:UINavigationController?;
    var shoppingListNavController:UINavigationController?;
    var mailNavController:UINavigationController?;
    
    let recipeImage:UIImage = UIImage(named: "knifeFork.png");
    let searchImage:UIImage = UIImage(named: "search.png");
    let shoppingListImage:UIImage = UIImage(named: "cart.png");
    let mailImage:UIImage = UIImage(named: "email-32.png");


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        
        loadRecipes();
        //emptyEntities();
        loadShoppingList();
        
        cycleTheGlobalMailComposer();

        
        //TabBar
        tabBar = UITabBarController();
        tabBar?.tabBar.barTintColor = UIColor.orangeColor();
        tabBar?.tabBar.tintColor = UIColor.whiteColor();
        
        
        //Views
        //Recipe
        var recipe:categoryViewController = categoryViewController();
        recipe.title = recipeTabBarTitle;
        recipe.tabBarItem.image = recipeImage;
        
        //Search
        var search:searchViewController = searchViewController();
        search.title = searchTabBarTitle;
        search.tabBarItem.image = searchImage;
        
        //Shoppinglist
        var shoppingList:ShoppingListViewController = ShoppingListViewController();
        shoppingList.title = shoppingListTabBarTitle;
        shoppingList.tabBarItem.image = shoppingListImage;
        
        //Mail
        var mail:SplitShoppingListViewController = SplitShoppingListViewController();
        mail.title = mailTabBarTitle;
        mail.tabBarItem.image = mailImage;
        
        //Navigation controllers
        recipeNavController = UINavigationController(rootViewController: recipe);
        recipeNavController?.navigationBar.barTintColor = UIColor.orangeColor();
        recipeNavController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()];
        recipeNavController?.navigationBar.tintColor = UIColor.whiteColor();

        searchNavController = UINavigationController(rootViewController: search);
        searchNavController?.navigationBar.barTintColor = UIColor.orangeColor();
        searchNavController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()];
        searchNavController?.navigationBar.tintColor = UIColor.whiteColor();
        
        shoppingListNavController = UINavigationController(rootViewController: shoppingList);
        shoppingListNavController?.navigationBar.barTintColor = UIColor.orangeColor();
        shoppingListNavController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()];
        shoppingListNavController?.navigationBar.tintColor = UIColor.whiteColor();
        
        mailNavController = UINavigationController(rootViewController: mail);
        mailNavController?.navigationBar.barTintColor = UIColor.orangeColor();
        mailNavController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()];
        mailNavController?.navigationBar.tintColor = UIColor.whiteColor();
        
        var ncs:NSArray = NSArray(objects: recipeNavController!, searchNavController!, shoppingListNavController!, mailNavController!);
        
        self.tabBar?.setViewControllers(ncs, animated: true);
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds);
        self.window?.rootViewController = tabBar;
        self.window?.makeKeyAndVisible();
        
        //Statusbar
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true);
        
        
        return true
    }
    func applicationWillResignActive(application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    func applicationDidEnterBackground(application: UIApplication)
    {
        DB.insertShoppingListIntoDB(shoppingListArray);
    }
    func applicationWillEnterForeground(application: UIApplication)
    {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    func applicationDidBecomeActive(application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    func applicationWillTerminate(application: UIApplication)
    {
        DB.insertShoppingListIntoDB(shoppingListArray);
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.henrikSwahn.ReceptProjekt" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("ReceptProjekt", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("ReceptProjekt.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: [NSMigratePersistentStoresAutomaticallyOption: true,NSInferMappingModelAutomaticallyOption: true], error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError.errorWithDomain("YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }
    
    //Own Functions
    private func loadRecipes()
    {
        DB.addRecipes();
        DB.addIngredients();
        DB.addRelations();
        var result:NSArray = DB.getEntity("Recipes", filter: "All", Predicate: "All");
        for(var i = 0; i < result.count; i++)
        {
            var temp = result.objectAtIndex(i) as Model;
            var hit = false;
            for(var j = 0; j < categoryArray.count && hit == false; j++)
            {
                if(temp.category == categoryArray[j])
                {
                    hit = true;
                }
            }
            if(hit == false)
            {
                categoryArray.append(temp.category);
                nrOfSections++;
            }
        }
        categoryArray.sort({$0 < $1});
        categoryArray.append("All");
    }
    private func emptyEntities()
    {
        DB.emptyEntity("Recipes");
        DB.emptyEntity("Ingredients");
        DB.emptyEntity("Relations");
    }
    private func loadShoppingList()
    {
        var result:NSArray = DB.getEntity("ShoppingList", filter: "All", Predicate: "All");
        for(var i = 0; i < result.count;i++)
        {
            var temp = result.objectAtIndex(i) as ShopListModel
            shoppingListArray.append(ShoppingListClass(name:temp.name, amount:temp.amount, unit:temp.unit));
        }
    }
}


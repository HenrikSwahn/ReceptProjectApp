//
//  searchViewController.swift
//  ReceptProjekt
//
//  Created by Henrik Swahn on 2014-10-14.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit

class searchViewController: UIViewController,UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource
{
    private var recipes = [RecipeClass]();
    private var filteredRecipes = [RecipeClass]();
    private var searchResult:NSArray?;
    
    private var ID:String?;
    
    private var searchTable:UITableView?;
    
    private var nameButton:UIButton?;
    private var ingreButton:UIButton?;
    
    private var searchByName = true;
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getRecipes();
        fillFilteredRecipes();
        println(filteredRecipes.count);
        setUpView();
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    //TableVIew
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return filteredRecipes.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:SearchTableViewCell = tableView.dequeueReusableCellWithIdentifier("searchCell") as SearchTableViewCell;
        
       
        cell.setRecipeImage(filteredRecipes[indexPath.row].getURL());
        cell.setNameLabel(filteredRecipes[indexPath.row].getName());
        return cell;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        self.view.endEditing(true);
        let predicate = filteredRecipes[indexPath.row].getId();
        var detailView:DetailRecipeViewController = DetailRecipeViewController();
        detailView.predicate = predicate;
        self.navigationController?.pushViewController(detailView, animated: true);
    }
    //Private
    private func getRecipes()
    {
        var result:NSArray = DB.getEntity("Recipes", filter: "All", Predicate: "All");
        
        for(var i = 0; i < result.count; i++)
        {
            var temp = result.objectAtIndex(i) as Model;
            recipes.append(RecipeClass(id:temp.id, name:temp.name, category:temp.category, desc:temp.desc, time:temp.time, URL:temp.imageURL));
        }
    }
    private func fillFilteredRecipes()
    {
        for(var i = 0; i < recipes.count;i++)
        {
            var temp:RecipeClass = RecipeClass(
                id: recipes[i].getId(),
                name: recipes[i].getName(),
                category: recipes[i].getCategory(),
                desc: recipes[i].getDesc(),
                time: recipes[i].getTime(),
                URL: recipes[i].getURL());
            filteredRecipes.append(temp);
        }
    }
    //View
    private func setUpView()
    {
        self.view.backgroundColor = UIColor.whiteColor();
        setUpTableView();
        
        self.nameButton = makeAllButton();
        self.view.addSubview(self.nameButton!);
        
        self.ingreButton = makeIngreButton();
        self.view.addSubview(self.ingreButton!);
    }
    private func setUpTableView()
    {
        searchTable = UITableView(frame:  CGRectMake(0,95,320,430));
        searchTable!.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
        searchTable!.dataSource = self;
        searchTable!.delegate = self;
        searchTable!.reloadData();
        searchTable!.registerClass(SearchTableViewCell.self, forCellReuseIdentifier: "searchCell");
        searchTable!.rowHeight = 50;
        searchTable!.scrollEnabled = true;
        searchTable!.userInteractionEnabled = true;
        searchTable!.bounces = true;
        searchTable!.backgroundColor = transparent;
        searchTable!.tableHeaderView = makeSearchBar();
        searchTable!.contentInset = UIEdgeInsetsMake(-64.0,0.0,0,0.0);
        self.view.addSubview(searchTable!);
    }
    private func makeSearchBar() ->UISearchBar
    {
        var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0,0,320,35));
        searchBar.delegate = self;
        return searchBar;
    }
    private func makeAllButton() ->UIButton
    {
        var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton;
        button.frame =  CGRectMake(10,69,140,21);
        button.setTitle(nameButtonStr, forState: UIControlState.Normal);
        button.backgroundColor = UIColor.orangeColor();
        button.layer.cornerRadius = 8;
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor.orangeColor().CGColor;
        button.clipsToBounds = true;
        button.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside);
        return button;
    }
    private func makeIngreButton() ->UIButton
    {
        var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton;
        button.frame =  CGRectMake(170,69,140,21);
        button.setTitle(ingreButtonStr, forState: UIControlState.Normal);
        button.backgroundColor = UIColor.whiteColor();
        button.layer.cornerRadius = 8;
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor.orangeColor().CGColor;
        button.clipsToBounds = true;
        button.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside);
        return button;
    }
    //SearchBar functions
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        if(self.searchByName == true)
        {
            var recipeAdded = false;
            if(searchText.isEmpty)
            {
                println("Nothing searched");
                filteredRecipes.removeAll(keepCapacity: false);
                fillFilteredRecipes();
                self.searchTable!.reloadData();
            }
            else
            {
                println("Something searched");
                filteredRecipes.removeAll(keepCapacity: false);
                for(var i = 0; i < recipes.count;i++)
                {
                    var str = recipes[i].getName();
                    if(str.rangeOfString(searchText) != nil)
                    {
                        filteredRecipes.append(recipes[i]);
                        self.searchTable?.reloadData();
                        recipeAdded = true;
                    }
                    else if((str.lowercaseString.rangeOfString(searchText) != nil))
                    {
                        filteredRecipes.append(recipes[i]);
                        self.searchTable?.reloadData();
                        recipeAdded = true;
                    }
                }
            }
            if(!recipeAdded && !searchText.isEmpty)
            {
                filteredRecipes.removeAll(keepCapacity: false);
                self.searchTable?.reloadData();
            }
        }
        else
        {
            var recipeAdded = false;
            if(searchText.isEmpty)
            {
                println("Nothing searched");
                filteredRecipes.removeAll(keepCapacity: false);
                fillFilteredRecipes();
                self.searchTable?.reloadData();
            }
            else
            {
                filteredRecipes.removeAll(keepCapacity: false);
                for(var i = 0; i < recipes.count; i++)
                {
                    var result:NSArray = DB.getEntity("Relations", filter: "fkRecipe", Predicate: recipes[i].getId())
                    var theRelations = [RelationClass]();
                    var theIngredients = [IngredientClass]();
                    for(var j = 0; j < result.count; j++)
                    {
                        let temp = result.objectAtIndex(j) as RelModel
                        theRelations.append(RelationClass(FkRecipe: temp.fkRecipe , FkIngredient: temp.fkIngredient, amount: temp.amount, unit: temp.unit));
                    }
                    for(var j = 0; j < theRelations.count; j++)
                    {
                        let FkIngr = theRelations[j].getFkIngredient();
                        result = DB.getEntity("Ingredients", filter: "id", Predicate: FkIngr);
                        let temp = result.objectAtIndex(0) as IngModel;
                        theIngredients.append(IngredientClass(id: temp.id, name: temp.name));
                    }
                    var hit = false;
                    for(var j = 0; j < theIngredients.count && !hit; j++)
                    {
                        var str = theIngredients[j].getName();
                        if(str.rangeOfString(searchText) != nil)
                        {
                            filteredRecipes.append(recipes[i])
                            self.searchTable?.reloadData();
                            hit = true;
                            recipeAdded = true;
                        }
                        else if(str.lowercaseString.rangeOfString(searchText) != nil)
                        {
                            filteredRecipes.append(recipes[i])
                            self.searchTable?.reloadData();
                            hit = true;
                            recipeAdded = true;
                        }
                    }
                }
            }
            if(!recipeAdded && !searchText.isEmpty)
            {
                filteredRecipes.removeAll(keepCapacity: false);
                self.searchTable?.reloadData();
            }
        }
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder();
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar)
    {
        searchBar.becomeFirstResponder();
    }
    
    //Button functions
    func buttonPressed(sender: UIButton)
    {
        if(sender.titleLabel?.text == nameButtonStr)
        {
            self.nameButton?.backgroundColor = UIColor.orangeColor();
            self.ingreButton?.backgroundColor = UIColor.whiteColor();
            self.searchByName = true;
        }
        else
        {
            self.nameButton?.backgroundColor = UIColor.whiteColor();
            self.ingreButton?.backgroundColor = UIColor.orangeColor();
            self.searchByName = false;
        }
    }
}

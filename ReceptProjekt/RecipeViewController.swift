//
//  RecipeViewController.swift
//  ReceptProjekt
//
//  Created by Henrik Swahn on 2014-10-16.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate
{
    private var predicate:String?;
    private var recipes = [RecipeClass]();
    private var reciTable:UITableView?;
    private var popup:UIActionSheet?;

    override func viewDidLoad()
    {
        super.viewDidLoad()
        getRecipes();
        setUpView();
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return recipes.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:RecipeTableViewCell = tableView.dequeueReusableCellWithIdentifier("recipeCell") as RecipeTableViewCell;
        
        cell.setRecipeImage(recipes[indexPath.row].getURL());
        cell.setNameLabel(recipes[indexPath.row].getName());
        cell.setTimeLabel(recipes[indexPath.row].getTime());
        
        return cell;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.reciTable!.deselectRowAtIndexPath(indexPath, animated: false);
        var detailRecipeView:DetailRecipeViewController = DetailRecipeViewController();
        
        detailRecipeView.predicate = recipes[indexPath.row].getId();
        
        self.navigationController?.pushViewController(detailRecipeView, animated: true);
    }
    private func setUpView()
    {
        self.view.backgroundColor = UIColor.whiteColor();
        //Navigationbar
        self.navigationItem.title = predicate!;
        self.navigationItem.rightBarButtonItem = makeSettingsButton();
        
        self.reciTable = makeTableView();
        self.view.addSubview(self.reciTable!);
    }
    private func makeTableView() ->UITableView
    {
        var table:UITableView = UITableView(frame:  CGRectMake(0,64,305,400));
        table.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
        table.dataSource = self;
        table.delegate = self;
        table.reloadData();
        table.registerClass(RecipeTableViewCell.self, forCellReuseIdentifier: "recipeCell");
        table.rowHeight = 50;
        table.scrollEnabled = true;
        table.userInteractionEnabled = true;
        table.bounces = true;
        table.contentInset = UIEdgeInsetsMake(-64.0,0.0,0,0.0);
        table.backgroundColor = transparent;
        
        return table;
    }
    private func makeSettingsButton() ->UIBarButtonItem
    {
        var item:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "settingsPressed:");
        return item;
    }
    private func getRecipes()
    {
        var result:NSArray = DB.getEntity("Recipes",filter: "category", Predicate: predicate!);
        
        for(var i = 0; i < result.count; i++)
        {
            var temp = result.objectAtIndex(i) as Model;
            
            recipes.append(RecipeClass(
                id: temp.id,
                name: temp.name,
                category: temp.category,
                desc: temp.desc,
                time: temp.time,
                URL: temp.imageURL));
        }
        recipes.sort({$0.getName() < $1.getName()});
    }
    
    //Buttons functions
    func settingsPressed(sender: UIBarButtonItem)
    {
        popup = UIActionSheet(
            title: "Sortera efter",
            delegate: self,
            cancelButtonTitle: "Avbryt",
            destructiveButtonTitle: nil,
            otherButtonTitles: "Namn",
            "Tid");
        popup!.tag = 1;
        popup!.showInView(UIApplication.sharedApplication().keyWindow);

    }
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
    {
        switch(popup!.tag)
            {
        case 1:
            switch(buttonIndex)
                {
            case 0:
                println("Avbryt");
            case 1:
                recipes.sort({$0.getName() < $1.getName()});
                self.reciTable!.reloadData();
            case 2:
                recipes.sort({$0.getTime().toInt() < $1.getTime().toInt()});
                self.reciTable!.reloadData();
            default:
                println("Default");
            }
        default:
            println("Jättefel");
            
        }
    }
    
    //Setter
    func setPredicate(predicate: String)
    {
        self.predicate = predicate;
    }
}

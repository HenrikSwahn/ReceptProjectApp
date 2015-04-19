//
//  addViewController.swift
//  ReceptProjekt
//
//  Created by Henrik Swahn on 2014-10-14.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit

class addViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    private var theRecipe:RecipeClass?;
    private var theRelations = [RelationClass]();
    private var theIngredients = [IngredientClass]();
    private var portions:Float?;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpInterface()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //Private
    private func setUpInterface()
    {
        self.view.backgroundColor = UIColor.orangeColor();
        //Add tableView
        self.view.addSubview(makeTableView());
        self.view.addSubview(makeBackButton());
    }
    //Create tableview
    private func makeTableView() ->UITableView
    {
        var ingreTable:UITableView = UITableView(frame:  CGRectMake(0,20,320,410));
        ingreTable.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
        ingreTable.dataSource = self;
        ingreTable.delegate = self;
        ingreTable.reloadData();
        ingreTable.registerClass(addTableViewCell.self, forCellReuseIdentifier: "addCell");
        ingreTable.rowHeight = 50;
        ingreTable.scrollEnabled = true;
        ingreTable.userInteractionEnabled = true;
        ingreTable.bounces = true;
        return ingreTable;
    }
    private func makeBackButton() ->UIButton
    {
        var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton;
        button.frame =  CGRectMake(240,440,70,30);
        button.setTitle(backButtonStr, forState: UIControlState.Normal);
        button.titleLabel?.font = UIFont.systemFontOfSize(13);
        button.layer.cornerRadius = 8;
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor.whiteColor().CGColor;
        button.addTarget(self, action: "back:", forControlEvents: UIControlEvents.TouchUpInside);
        return button;
    }
    //TableVIew
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return theIngredients.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:addTableViewCell = tableView.dequeueReusableCellWithIdentifier("addCell") as addTableViewCell;
        
        var strAmount = theRelations[indexPath.row].getAmount();
        var aMount = (strAmount as NSString).floatValue;
        aMount = aMount * self.portions!
        let roundedAmount:NSString = NSString(format:"%.1f", aMount);
        cell.setCellProperties(
            theIngredients[indexPath.row].getName(),
            amount: roundedAmount,
            unit: theRelations[indexPath.row].getUnit());
        return cell;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
       
        var strAmount = theRelations[indexPath.row].getAmount();
        var aMount = (strAmount as NSString).floatValue;
        aMount = aMount * self.portions!
            
        var hit = false;
        var pos: Int?;
        for(var j = 0; j < shoppingListArray.count && hit == false; j++)
        {
            if(theIngredients[indexPath.row].getName() == shoppingListArray[j].getName())
            {
                hit = true;
                pos = j;
            }
        }
        if(hit == false)
        {
            shoppingListArray.append(
                ShoppingListClass(
                    name: theIngredients[indexPath.row].getName(), amount:aMount,unit:theRelations[indexPath.row].getUnit()));
        }
        else
        {
            shoppingListArray[pos!].addToAmount(aMount);
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
    }
    //GoBack
    func back(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    //Setters
    func setTheRecipe(theRecipe: RecipeClass)
    {
        self.theRecipe = theRecipe;
        self.navigationItem.title = theRecipe.getName();
    }
    func setTheIngredients(theIngredients: [IngredientClass])
    {
        self.theIngredients = theIngredients;
    }
    func setTheRelations(theRelations: [RelationClass])
    {
        self.theRelations = theRelations;
    }
    func setPortionSize(size: Float)
    {
        self.portions = size;
    }
}

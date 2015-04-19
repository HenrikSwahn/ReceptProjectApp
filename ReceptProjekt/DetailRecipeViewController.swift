//
//  DetailRecipeViewController.swift
//  ReceptProjekt
//
//  Created by Henrik Swahn on 2014-10-13.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit
import QuartzCore

class DetailRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate
{
    var predicate: String?;
    
    private var theRecipe:RecipeClass?;
    private var theRelations = [RelationClass]();
    private var theIngredients = [IngredientClass]();
    private var result:NSArray?;
    private var portions:Float = 2.0;
    
    //UI
    private var textArea: UITextView?;
    private var detailImageView:UIImageView?;
    private var ingredientTable:UITableView?;
    
    private var portionLabel:UILabel?;
    private var popup:UIActionSheet?;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getRecipe();
        getRelations();
        getIngredients();
        setUpView();
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    //TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return theRelations.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:ingedientTableViewCell = tableView.dequeueReusableCellWithIdentifier("ingredientCell") as ingedientTableViewCell;
        cell.backgroundColor = transparent;
        
        //Multiply the amount with portionsize
        var strAmount = theRelations[indexPath.row].getAmount();
        var amount = (strAmount as NSString).floatValue;
        amount = amount * portions;
        var roundedAmount:NSString = NSString(format:"%.1f", amount);
        
        cell.setCellProperties(
            theIngredients[indexPath.row].getName(),
            amount: roundedAmount,
            unit: theRelations[indexPath.row].getUnit());
        return cell;
    }
    
    //Private
    private func getRecipe()
    {
        result = DB.getEntity("Recipes",filter:"id", Predicate: predicate!);
        var temp = result?.objectAtIndex(0) as Model;
        theRecipe = RecipeClass(id: temp.id,
            name: temp.name,
            category: temp.category,
            desc: temp.desc,
            time: temp.time,
            URL: temp.imageURL);
    }
    private func getIngredients()
    {
        for(var i = 0; i < theRelations.count; i++)
        {
            let FkIngr = theRelations[i].getFkIngredient();
            result = DB.getEntity("Ingredients", filter: "id", Predicate: FkIngr);
            let temp = result?.objectAtIndex(0) as IngModel;
            theIngredients.append(IngredientClass(id: temp.id, name: temp.name));
        }
    }
    private func getRelations()
    {
        result = DB.getEntity("Relations", filter: "fkRecipe", Predicate: predicate!)
        for(var i = 0; i < result!.count; i++)
        {
            var temp = result?.objectAtIndex(i) as RelModel;
            theRelations.append(RelationClass(
                FkRecipe: temp.fkRecipe,
                FkIngredient: temp.fkIngredient,
                amount: temp.amount, unit:
                temp.unit));
        }
    }
    
    //Setting upp view
    private func setUpView()
    {
        self.view.backgroundColor = UIColor.whiteColor();
        
        self.navigationItem.title = theRecipe?.getName();
        self.navigationItem.rightBarButtonItem = makeUIBarButtonItem();
        
        setUpTextView();
        setUpImageView();
        setUpCategoryTable();
        
        self.view.addSubview(makeAddAllButton());
        self.view.addSubview(makeAddButton());
        
        self.view.addSubview(makeTimeImgView());
        self.view.addSubview(makeTimelabel());
        
        self.setUpPortionlabel();
        self.view.addSubview(self.makePortionImgView());
        
    }
    private func setUpTextView()
    {
        textArea = UITextView(frame: CGRectMake(10,220,300,203));
        textArea?.contentInset = UIEdgeInsetsMake(-65,0,0,0);
        textArea?.text = theRecipe?.getDesc();
        textArea?.backgroundColor = transparent;
        textArea?.editable = false;
        self.view.addSubview(textArea!);
    }
    private func setUpImageView()
    {
        detailImageView = UIImageView(frame: CGRectMake(10,74,150,100));
        
        var img:UIImage? = UIImage(data: NSData(contentsOfURL: NSURL(string: self.theRecipe!.getURL())));
        
        if(img != nil) //If img was not found on given location
        {
            detailImageView?.image = img;
        }
        else
        {
            detailImageView?.image = UIImage(named: "placeholder.png");
            detailImageView?.contentMode = UIViewContentMode.ScaleAspectFit;
        }
        detailImageView?.layer.borderWidth = 1;
        detailImageView?.layer.borderColor = UIColor.orangeColor().CGColor;
        detailImageView?.contentMode = UIViewContentMode.ScaleAspectFit;
        
        self.view.addSubview(detailImageView!);
    }
    private func setUpCategoryTable()
    {
        ingredientTable = UITableView(frame: CGRectMake(160,74,150,110));
        ingredientTable!.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
        ingredientTable!.dataSource = self;
        ingredientTable!.delegate = self;
        ingredientTable!.registerClass(ingedientTableViewCell.self, forCellReuseIdentifier: "ingredientCell");
        ingredientTable!.rowHeight = 20;
        ingredientTable!.scrollEnabled = true;
        ingredientTable!.userInteractionEnabled = true;
        ingredientTable!.bounces = true;
        ingredientTable!.backgroundColor = transparent;
        ingredientTable!.separatorStyle = UITableViewCellSeparatorStyle.None;
        ingredientTable!.contentInset = UIEdgeInsetsMake(15.0,0.0,0,0.0);
        self.view.addSubview(ingredientTable!);
    }
    private func makeAddAllButton() ->UIButton
    {
        var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton;
        button.frame = CGRectMake(165,185,70,30);
        button.setTitle(addAllStr, forState: UIControlState.Normal);
        button.titleLabel?.textColor = UIColor.blackColor();
        button.titleLabel?.textColor = UIColor.blackColor();
        button.layer.cornerRadius = 8;
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor.orangeColor().CGColor;
        button.clipsToBounds = true;
        button.addTarget(self, action: "buttonFunction:", forControlEvents: UIControlEvents.TouchUpInside)
        return button;
    }
    private func makeAddButton() ->UIButton
    {
        var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton;
        button.frame =  CGRectMake(240,185,70,30);
        button.setTitle(addStr, forState: UIControlState.Normal);
        button.titleLabel?.textColor = UIColor.blackColor();
        button.titleLabel?.textColor = UIColor.blackColor();
        button.layer.cornerRadius = 8;
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor.orangeColor().CGColor;
        button.clipsToBounds = true;

        button.addTarget(self, action: "buttonFunction:", forControlEvents: UIControlEvents.TouchUpInside);
        return button;
    }
    private func makeUIBarButtonItem() ->UIBarButtonItem
    {
        var img:UIImage = UIImage(named: "plus.png");
        var item:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "barButtonClicked:");
        
        return item;
    }
    private func makeTimelabel() ->UILabel
    {
        var label:UILabel = UILabel(frame: CGRectMake(35,178,100,15));
        label.text = "\(theRecipe!.getTime())  min";
        return label;
    }
    private func makeTimeImgView() ->UIImageView
    {
        var timeView:UIImageView = UIImageView(frame: CGRectMake(10,180,15,15));
        let timeImage = UIImage(named: "hourglass.png");
        timeView.image = timeImage;
        
        return timeView;
    }
    private func setUpPortionlabel()
    {
        if(self.portionLabel == nil)
        {
            self.portionLabel = UILabel(frame: CGRectMake(35,200,100,20));
            self.portionLabel?.text = "\(Int(self.portions)) st";
            self.view.addSubview(self.portionLabel!);
        }
        else
        {
            self.portionLabel?.text = "\(Int(self.portions)) st";
        }
    }
    private func makePortionImgView() ->UIImageView
    {
        var timeView:UIImageView = UIImageView(frame: CGRectMake(10,203,15,15));
        let timeImage = UIImage(named: "chart_pie.png");
        timeView.image = timeImage;
        
        return timeView;
    }
    
    func barButtonClicked(sender: UIBarButtonItem)
    {
        popup = UIActionSheet(
            title: "Antal portioner",
            delegate: self,
            cancelButtonTitle: "Avbryt",
            destructiveButtonTitle: nil,
            otherButtonTitles:
            sizeX2Str,
            sizeX4Str,
            sizeX6Str,
            sizeX8Str);
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
                self.portions = 2.0;
                self.ingredientTable?.reloadData();
                self.setUpPortionlabel();
                
            case 2:
                self.portions = 4.0;
                self.ingredientTable?.reloadData();
                self.setUpPortionlabel();
                
            case 3:
                self.portions = 6.0;
                self.ingredientTable?.reloadData();
                self.setUpPortionlabel();
                
            case 4:
                self.portions = 8.0;
                self.ingredientTable?.reloadData();
                self.setUpPortionlabel();
    
            default:
                println("Default");
            }
        default:
            println("Jättefel");
            
        }
    }
    private func add()
    {
        var addView:addViewController = addViewController();
        addView.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal;
        addView.setTheRecipe(self.theRecipe!);
        addView.setTheIngredients(self.theIngredients);
        addView.setTheRelations(self.theRelations);
        addView.setPortionSize(self.portions);
        self.presentViewController(addView, animated: true, completion: nil);
    }
    private func addAll()
    {
        for(var i = 0; i < theIngredients.count; i++)
        {
            var strAmount = theRelations[i].getAmount();
            var aMount = (strAmount as NSString).floatValue;
            aMount = aMount * portions;
            
            var hit = false;
            var pos: Int?;
            for(var j = 0; j < shoppingListArray.count && hit == false; j++)
            {
                if(theIngredients[i].getName() == shoppingListArray[j].getName())
                {
                    hit = true;
                    pos = j;
                }
            }
            if(hit == false)
            {
                shoppingListArray.append(
                    ShoppingListClass(
                        name: theIngredients[i].getName(), amount:aMount, unit:theRelations[i].getUnit()));
            }
            else
            {
                shoppingListArray[pos!].addToAmount(aMount);
            }
        }
        for(var i = 0; i < shoppingListArray.count;i++)
        {
            println(shoppingListArray[i].getName());
        }
    }
    func buttonFunction(sender: UIButton)
    {
        if(sender.titleLabel?.text == addAllStr)
        {
            addAll();
        }
        else
        {
            add();
        }
    }

}

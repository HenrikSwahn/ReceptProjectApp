//
//  ShoppingListViewController.swift
//  ReceptProjekt
//
//  Created by Henrik Swahn on 2014-10-14.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    private var shoppingListTable: UITableView?;
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor();
        setUpInterface()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(animated: Bool)
    {
        self.shoppingListTable?.reloadData();
    }
    
    //Private
    private func setUpInterface()
    {
        self.navigationItem.title = "ShoppingList";
        //Add
        self.shoppingListTable = makeTableView();
        self.view.addSubview(shoppingListTable!);
    }
    //Create tableview
    private func makeTableView() ->UITableView
    {
        var shoppListTable:UITableView = UITableView(frame:  CGRectMake(0,0,320,430));
        shoppListTable.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
        shoppListTable.dataSource = self;
        shoppListTable.delegate = self;
        shoppListTable.reloadData();
        shoppListTable.registerClass(shoppingListTableViewCell.self, forCellReuseIdentifier: "shoppListCell");
        shoppListTable.rowHeight = 50;
        shoppListTable.scrollEnabled = true;
        shoppListTable.userInteractionEnabled = true;
        shoppListTable.bounces = true;
        shoppListTable.backgroundColor = transparent;
        
        return shoppListTable;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        println(shoppingListArray.count);

        return shoppingListArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:shoppingListTableViewCell = tableView.dequeueReusableCellWithIdentifier("shoppListCell") as shoppingListTableViewCell;
        
        cell.setCellProperties(shoppingListArray[indexPath.row].getName(),
            amount: shoppingListArray[indexPath.row].getAmount(),
            unit: shoppingListArray[indexPath.row].getUnit());
        return cell;
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if(editingStyle == UITableViewCellEditingStyle.Delete)
        {
            shoppingListArray.removeAtIndex(indexPath.row);
            tableView.reloadData();
        }
    }
}

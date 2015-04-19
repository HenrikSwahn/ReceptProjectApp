//
//  shoppingListTableViewController.swift
//  ReceptProjekt
//
//  Created by Henrik Swahn on 2014-10-13.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit

class shoppingListTableViewController: UITableViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpTable();
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return shoppingListArray.count;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
         var cell:shoppingListTableViewCell = tableView.dequeueReusableCellWithIdentifier("shoppingCell") as shoppingListTableViewCell;
        
        cell.setNameLabel(shoppingListArray[indexPath.row].getName());
        cell.setAmountLabel(shoppingListArray[indexPath.row].getAmount());
        cell.setUnitLabel(shoppingListArray[indexPath.row].getUnit());
        return cell;
    }
    
    private func setUpTable()
    {
        self.tableView.registerClass(shoppingListTableViewCell.self, forCellReuseIdentifier: "shoppingCell");
        
        self.tableView.rowHeight = 25;
        self.tableView.scrollEnabled = true;
        self.tableView.userInteractionEnabled = true;
        self.tableView.bounces = true;
    }
}

  
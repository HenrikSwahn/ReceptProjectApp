//
//  categoryViewController.swift
//  ReceptProjekt
//
//  Created by Henrik Swahn on 2014-10-13.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit

class categoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    private var categoryTable:UITableView?;
    private var backgroundImageView:UIImageView?;
    
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
        self.navigationItem.title = categoryViewTitle;
        
        self.view.backgroundColor = UIColor.whiteColor();
        
        self.backgroundImageView = makeBackgroundImageView();
        self.view.addSubview(self.backgroundImageView!);
        
        self.categoryTable = makeTableView();
        self.view.addSubview(self.categoryTable!);
    }
    //Create tableview
    private func makeTableView() ->UITableView
    {
        var table:UITableView = UITableView(frame:  CGRectMake(160,64,160,367));
        table.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
        table.dataSource = self;
        table.delegate = self;
        table.reloadData();
        table.registerClass(categoryTableViewCell.self, forCellReuseIdentifier: "categoryCell");
        table.rowHeight = 40;
        table.scrollEnabled = true;
        table.userInteractionEnabled = true;
        table.bounces = true;
        table.backgroundColor = white;
        table.separatorStyle = UITableViewCellSeparatorStyle.None;
        return table;
    }
    //Create background
    private func makeBackgroundImageView() ->UIImageView
    {
        let background:UIImage = UIImage(named: "fineDin2.png");
        var view:UIImageView = UIImageView(frame: CGRectMake(10,64,300,367));
        view.image = background;
        return view;
    }    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return categoryArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:categoryTableViewCell = tableView.dequeueReusableCellWithIdentifier("categoryCell") as categoryTableViewCell;
        
        cell.backgroundColor = transparent;
        cell.setNameLabel(categoryArray[indexPath.row]);
        return cell;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: false);
        var recipeView:RecipeViewController = RecipeViewController();
        recipeView.setPredicate(categoryArray[indexPath.row]);
        self.navigationController?.pushViewController(recipeView, animated: true);
    }
}

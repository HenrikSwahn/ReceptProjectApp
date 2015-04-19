//
//  searchTableViewController.swift
//  ReceptProjekt
//
//  Created by Henrik Swahn on 2014-10-13.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit

class searchTableViewController: UITableViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpInterface();
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      
        return 0
    }
    
    //Private
    private func setUpInterface()
    {
        self.navigationItem.title = "Sök";
    }
}

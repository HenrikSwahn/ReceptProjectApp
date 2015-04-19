//
//  splitShoppingListViewController.swift
//  ReceptProjekt
//
//  Created by Henrik Swahn on 2014-10-15.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit
import MessageUI

class SplitShoppingListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate
{
    private var splitListTabel:UITableView?;
    private var continiueButton:UIButton?;
    private var rollbackButton:UIButton?;
    
    private var selectedIngredients = [ShoppingListClass]();
    private var selectedIndexPaths = [NSIndexPath]();
    
    private var popup:UIActionSheet?;

    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpView();
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool)
    {
        self.splitListTabel?.reloadData();
    }
    //SetUpView
    private func setUpView()
    {
        self.view.backgroundColor = UIColor.whiteColor();
        
        self.splitListTabel = makeTableView();
        self.view.addSubview(self.splitListTabel!);
        
        self.continiueButton = makeContButton();
        self.view.addSubview(self.continiueButton!);
        
        self.rollbackButton = makeRollbackButton();
        self.view.addSubview(self.rollbackButton!);
    }
    private func makeTableView() ->UITableView
    {
        var table:UITableView = UITableView(frame: CGRectMake(0,0,305,380));
        table.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
        table.dataSource = self;
        table.delegate = self;
        table.registerClass(shoppingListTableViewCell.self, forCellReuseIdentifier: "shoppListCell");
        table.rowHeight = 50;
        table.scrollEnabled = true;
        table.userInteractionEnabled = true;
        table.bounces = true;
        table.backgroundColor = transparent;
        
        return table;
    }
    private func makeContButton() ->UIButton
    {
        var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton;
        button.frame = CGRectMake(170,385,140,30);
        button.setTitle(contBtnStr, forState: UIControlState.Normal);
        button.titleLabel?.textColor = UIColor.blackColor();
        button.titleLabel?.textColor = UIColor.blackColor();
        button.layer.cornerRadius = 8;
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor.orangeColor().CGColor;
        button.clipsToBounds = true;
        button.addTarget(self, action: "buttonFunction:", forControlEvents: UIControlEvents.TouchUpInside)
        return button;
    }
    private func makeRollbackButton() ->UIButton
    {
        var button:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton;
        button.frame = CGRectMake(10,385,140,30);
        button.setTitle(rollbackBtnStr, forState: UIControlState.Normal);
        button.titleLabel?.textColor = UIColor.blackColor();
        button.titleLabel?.textColor = UIColor.blackColor();
        button.layer.cornerRadius = 8;
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor.orangeColor().CGColor;
        button.clipsToBounds = true;
        button.addTarget(self, action: "buttonFunction:", forControlEvents: UIControlEvents.TouchUpInside)
        return button;
    }
    
    //TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return shoppingListArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:shoppingListTableViewCell = tableView.dequeueReusableCellWithIdentifier("shoppListCell") as shoppingListTableViewCell;
        cell.selectionStyle = UITableViewCellSelectionStyle.Default;
        
        cell.setCellProperties(shoppingListArray[indexPath.row].getName(),
            amount: shoppingListArray[indexPath.row].getAmount(),
            unit: shoppingListArray[indexPath.row].getUnit());
        return cell;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var cell = tableView.cellForRowAtIndexPath(indexPath);
        if(cell?.accessoryType != UITableViewCellAccessoryType.Checkmark)
        {
            selectedIngredients.append(shoppingListArray[indexPath.row]);
            selectedIndexPaths.append(indexPath);
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark;
            tableView.deselectRowAtIndexPath(indexPath, animated: true);
        }
        else
        {
            cell?.accessoryType = UITableViewCellAccessoryType.None;
            var pos = -1;
            for(var i = 0; i < selectedIngredients.count && pos == -1; i++)
            {
                if(selectedIngredients[i].getName() == shoppingListArray[indexPath.row].getName())
                {
                    if(selectedIngredients[i].getAmount() == shoppingListArray[indexPath.row].getAmount())
                    {
                        if(selectedIngredients[i].getUnit() == shoppingListArray[indexPath.row].getUnit())
                        {
                            pos = i;
                        }
                    }
                }
            }
            if(pos != -1)
            {
                selectedIngredients.removeAtIndex(pos);
                selectedIndexPaths.removeAtIndex(pos);
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true);
        }
    }
    
    //Buttonfunction
    func buttonFunction(sender: UIButton)
    {
        for ingr in selectedIngredients
        {
            println(ingr.getName());
        }
        
        if(sender.titleLabel!.text == rollbackBtnStr)
        {
            for(var i = 0; i < selectedIngredients.count; i++)
            {
                var cell = splitListTabel?.cellForRowAtIndexPath(selectedIndexPaths[i]);
                cell?.accessoryType = UITableViewCellAccessoryType.None;
            }
            selectedIndexPaths.removeAll(keepCapacity: false);
            selectedIngredients.removeAll(keepCapacity: false);
        }
        else
        {
            popup = UIActionSheet(
                title: "SMS eller Mail",
                delegate: self,
                cancelButtonTitle: "Avbryt",
                destructiveButtonTitle: nil,
                otherButtonTitles: "SMS",
                "Mail");
            popup!.tag = 1;
            popup!.showInView(UIApplication.sharedApplication().keyWindow);
        }
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
                    smsChosen();
                case 2:
                    mailChosen();
            default:
                    println("Default");
            }
        default:
            println("Jättefel");
        
        }
    }
    private func smsChosen()
    {
        if(MFMessageComposeViewController.canSendText())
        {
            var messageBody = "";
            for(var i = 0; i < selectedIngredients.count; i++)
            {
                messageBody += "\(selectedIngredients[i].getName()) \(selectedIngredients[i].getAmount()) \(selectedIngredients[i].getUnit()) \n";
            }
            
            var msgView: MFMessageComposeViewController = MFMessageComposeViewController();
            msgView.messageComposeDelegate = self;
            msgView.body = messageBody;
            
            self.presentViewController(msgView, animated: true, completion: nil);
            
        }
    }
    private func mailChosen()
    {
        if(MFMailComposeViewController.canSendMail())
        {
            var messageBody = "";
            for(var i = 0; i < selectedIngredients.count; i++)
            {
                messageBody += "\(selectedIngredients[i].getName()) \(selectedIngredients[i].getAmount()) \(selectedIngredients[i].getUnit()) \n";
            }
            println(messageBody);
            
            cycleTheGlobalMailComposer();
            mailComposer?.mailComposeDelegate = self;
            mailComposer?.setMessageBody(messageBody, isHTML: false);
        
            self.presentViewController(mailComposer!, animated: true, completion: nil)
        }
    }
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!)
    {
        var errorView:UIAlertView = UIAlertView(title: "Error", message: "Yo", delegate: self, cancelButtonTitle: "Cancel");
        errorView.show();
    }
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult)
    {
        
    }
}

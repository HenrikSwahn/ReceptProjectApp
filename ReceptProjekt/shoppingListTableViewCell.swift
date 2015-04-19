//
//  shoppingListTableViewCell.swift
//  ReceptProjekt
//
//  Created by Henrik Swahn on 2014-10-14.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit


//Custom cell for ShoppingListView
class shoppingListTableViewCell: UITableViewCell
{
    private var name:UILabel?;
    private var amount:UILabel?;
    private var unit:UILabel?;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        setUpCell();
    }
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib();
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated);
    }
    
    //Private
    private func setUpCell()
    {
        name = UILabel(frame:  CGRectMake(5,5,150,45));
        self.addSubview(name!);
        
        amount = UILabel(frame:  CGRectMake(160,5,60,45));
        amount?.textAlignment = .Right;
        self.addSubview(amount!);
        
        unit = UILabel(frame:  CGRectMake(225,5,75,45));
        self.addSubview(unit!);
        
        self.selectionStyle = UITableViewCellSelectionStyle.None;
    }
    
    //Setter
    func setCellProperties(name: String, amount: Float, unit: String)
    {
        self.name?.text = name;
        var roundedAmount:NSString = NSString(format: "%.1f",amount);
        self.amount?.text = roundedAmount;
        self.unit?.text = unit;
        self.checkAmount();
    }
    
    private func checkAmount()
    {
        if(unit?.text == "dl")
        {
            var NSStringValue:NSString = NSString(string: amount!.text!);
            var value = NSStringValue.floatValue;
            if(value > 10)
            {
                value = value / 10;
                
                var roundedVal = NSString(format: "%.1f", value);
                amount?.text = roundedVal;
                unit?.text = "l";
            }
        }
        else if(unit?.text == "gr")
        {
            var NSStringValue:NSString = NSString(string: amount!.text!);
            var value = NSStringValue.floatValue;
            if(value > 1000)
            {
                value = value / 1000;
                
                var roundedVal = NSString(format: "%.1f", value);
                amount?.text = roundedVal;
                unit?.text = "kg";
                
            }
        }
    }
}

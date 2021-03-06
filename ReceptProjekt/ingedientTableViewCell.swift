//
//  ingedientTableViewCell.swift
//  ReceptProjekt
//
//  Created by Henrik Swahn on 2014-10-14.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit

class ingedientTableViewCell: UITableViewCell
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
        name = UILabel(frame:  CGRectMake(5,-15,70,15));
        name?.font = UIFont.systemFontOfSize(9);
        self.addSubview(name!);
        
        amount = UILabel(frame:  CGRectMake(80,-15,30,15));
        amount?.font = UIFont.systemFontOfSize(9);
        amount?.textAlignment = .Right;
        self.addSubview(amount!);
        
        unit = UILabel(frame:  CGRectMake(115,-15,30,15));
        unit?.font = UIFont.systemFontOfSize(9);
        self.addSubview(unit!);
        
        self.selectionStyle = UITableViewCellSelectionStyle.None;
    }
    
    //Setter
    func setCellProperties(name: String, amount: String, unit: String)
    {
        self.name?.text = "-\(name)";
        self.amount?.text = amount;
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

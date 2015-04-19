//
//  categoryTableViewCell.swift
//  ReceptProjekt
//
//  Created by Henrik Swahn on 2014-10-13.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit

class categoryTableViewCell: UITableViewCell
{
    private var label:UILabel?;
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
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setUpCell()
    {
        //Label
        label = UILabel(frame:  CGRectMake(0,0,100,40));
        label?.textAlignment = .Left
        self.addSubview(label!);
        
        //Cell Accessory type
        self.accessoryView = UIImageView(image: UIImage(named: "orgArrow.png"));
    }
    //Setter
    func setNameLabel(name: String)
    {
        self.label?.text = name;
    }
}

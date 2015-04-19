//
//  SearchTableViewCell.swift
//  ReceptProjekt
//
//  Created by Henrik Swahn on 2014-10-14.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell
{

    private var nameLabel:UILabel?;
    private var recipeImage:UIImage?;
    private var imgView:UIImageView?;

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
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpCell()
    {
        imgView = makeImageView();
        self.addSubview(imgView!);
        
        //Labels
        nameLabel = UILabel(frame: CGRectMake(55,5,180,45));
        self.addSubview(nameLabel!);
    }
    private func makeImageView() ->UIImageView
    {
        var imageView:UIImageView = UIImageView(frame:  CGRectMake(5,5,45,45));
        imgView?.backgroundColor = UIColor.greenColor();
        return imageView;
    }
    
    //Setter
    func setNameLabel(name: String)
    {
        self.nameLabel?.text = name;
    }
    func setRecipeImage(url: String)
    {
        var img:UIImage? = UIImage(data: NSData(contentsOfURL: NSURL(string: url)));
        
        if(img != nil)  //If img was not found on given location
        {
            imgView?.image = img;
        }
        else
        {
            imgView?.image = UIImage(named: "placeholder.png");
            imgView?.contentMode = UIViewContentMode.ScaleAspectFit;
            
        }
        imgView?.layer.borderWidth = 1;
        imgView?.layer.borderColor = UIColor.orangeColor().CGColor;
    }
}

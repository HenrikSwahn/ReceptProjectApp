//
//  RecipeTableViewCell.swift
//  ReceptProjekt
//
//  Created by Henrik Swahn on 2014-10-13.
//  Copyright (c) 2014 Henrik Swahn. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell
{

    private var nameLabel:UILabel?;
    private var timeLabel:UILabel?;
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
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }
    
    //Private
    private func setUpCell()
    {
        imgView = makeImageView();
        self.addSubview(imgView!);
        
        //Labels
        nameLabel = UILabel(frame: CGRectMake(55,0,150,50));
        self.addSubview(nameLabel!);
        
        timeLabel = UILabel(frame: CGRectMake(210,0,70,50));
        self.addSubview(timeLabel!);
        
        self.accessoryView = UIImageView(image: UIImage(named: "orgArrow.png"));
        
    }
    private func makeImageView() ->UIImageView
    {
        var imageView:UIImageView = UIImageView(frame:  CGRectMake(5,5,40,40));
        return imageView;
    }
    
    //Setter
    func setNameLabel(name: String)
    {
        self.nameLabel?.text = name;
    }
    func setTimeLabel(time: String)
    {
        self.timeLabel?.text = time + " min";
    }
    func setRecipeImage(url: String)
    {
        var img:UIImage? = UIImage(data: NSData(contentsOfURL: NSURL(string: url)));
        
        if(img != nil) //If img was not found on given location
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

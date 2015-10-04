//
//  CustomTableViewCell.swift
//  FoodPin
//
//  Created by pingyandong on 15/6/8.
//  Copyright (c) 2015年 Abaobao. All rights reserved.
//

import UIKit
//http://betaimg.abaobao.net/alumb170/1bf6ef2321c7875d_800x510.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef2321c79a27_800x600.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef2321c790da_800x182.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef2321c85ee5_800x1905.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef2321c8a584_800x1067.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef2321c8b783_800x196.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef2321c8afd4_800x800.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef2321ca8cc0_800x1067.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef2321cab14d_800x1067.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef2322279bf1_800x182.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef2322279052_800x196.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef232227fc0e_800x1905.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef232228e511_800x800.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef23222a9e02_800x173.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef23222aeb93_800x1067.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef23222aaad4_800x1067.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef23222b3f6d_800x510.jpg
//http://betaimg.abaobao.net/alumb170/1bf6ef23222f655d_800x600.jpg

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var heatIconImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

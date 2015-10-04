//
//  Restaurant.swift
//  FoodPin
//
//  Created by pingyandong on 15/6/8.
//  Copyright (c) 2015年 Abaobao. All rights reserved.
//

import Foundation
import CoreData

//class Restaurant {
//    var name:String?
//    var type:String?
//    var location:String?
//    var image:String?
//    var isVisited:Bool?
//    
//    init(name:String,type:String,location:String,image:String,isVisited:Bool) {
//        self.name = name
//        self.type = type
//        self.location = location
//        self.image = image
//        self.isVisited = isVisited
//    }
//}

class Restaurant:NSManagedObject {
    @NSManaged var name:String!
    @NSManaged var type:String!
    @NSManaged var location:String!
    @NSManaged var image:NSData!
    @NSManaged var isVisited:NSNumber!
}
//
//  DetailViewController.swift
//  FoodPin
//
//  Created by pingyandong on 15/6/8.
//  Copyright (c) 2015年 Abaobao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var restaurantImageView: UIImageView!
    var restaurantImage:String!
    var restaurant:Restaurant!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.restaurant.name
//        self.restaurantImageView.image = UIImage(named: restaurantImage)
        self.restaurantImageView.image = UIImage(data: restaurant.image)
        self.tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2);
        self.tableView.tableFooterView = UIView(frame:
            CGRectZero)
        self.tableView.separatorColor = UIColor(red:
                240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0,
                alpha: 0.8)
        
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(segue:UIStoryboardSegue) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailTableViewCell", forIndexPath: indexPath)
            as! DetailTableViewCell
        // Configure the cell...
        switch indexPath.row {
        case 0:
            cell.filedLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.filedLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.filedLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.filedLabel.text = "Been here"
            cell.valueLabel.text = (restaurant.isVisited.boolValue) ? "Yes, I’ve been here before" : "No"
        default:
            cell.filedLabel.text = ""
            cell.valueLabel.text = ""
        }
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

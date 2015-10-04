//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by pingyandong on 15/6/8.
//  Copyright (c) 2015年 Abaobao. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController,NSFetchedResultsControllerDelegate,UISearchResultsUpdating {
    var fetchResultsController:NSFetchedResultsController!
    var restaurants:[Restaurant] = []
    var searchResults:[Restaurant] = []

   
//    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "Thai Cafe"]
//    
//    var restaurantLocations = ["Hong Kong 打卡上打粮食局打卡机读卡升级打开垃圾堆里卡时间到了撒娇的了解到了敬爱的踩空间看见了开关机枫蓝国际法兰克福飓风桑迪开发仅此IEC看电视可适当；才开始的了；费开的的会计师肯德基阿斯科利到家了看手机佛教是看得见啊是快乐到家啊是来得及阿里山可敬的萨拉角度来看撒娇的", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong",
//        "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York",
//        "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
//    
//    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American",
//        "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish",
//        "Spanish", "Spanish", "British", "Thai"]
//    
//    var restaurantImages = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg", "cafeloisl.jpg",
//        "petiteoyster.jpg", "forkeerestaurant.jpg", "posatelier.jpg", "bourkestreetbakery.jpg",
//        "haighschocolate.jpg", "palominoespresso.jpg", "upstate.jpg", "traif.jpg",
//        "grahamavenuemeats.jpg", "wafflewolf.jpg", "fiveleaves.jpg", "cafelore.jpg",
//        "confessional.jpg", "barrafina.jpg", "donostia.jpg", "royaloak.jpg", "thaicafe.jpg"]
    
    var restaurantIsVisited = [Bool](count: 21, repeatedValue: false)
    
    //    override func prefersStatusBarHidden() -> Bool {
    //            return true
    //    }
    
   var searchController:UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain,
            target: nil, action: nil)
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        /********************************UISearchBar**********************************************/
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        searchController.searchBar.tintColor = UIColor.whiteColor()
//        searchController.searchBar.barTintColor = UIColor(red: 231.0/255.0, green: 95.0/255.0, blue: 53.0/255.0, alpha: 0.3)
//        searchController.searchBar.prompt = "Quick Search"
        searchController.searchBar.placeholder = NSLocalizedString("Search your restaurant", comment: "Search your restaurant")
        
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
        searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        
        /********************************从CoreData中获取数据**********************************************/
        let fetchRequest = NSFetchRequest(entityName: "Restaurant")
        let sortDescription = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescription]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            var e:NSError?
            var result: Bool
            do {
                try fetchResultsController.performFetch()
                result = true
            } catch let error as NSError {
                e = error
                result = false
            }
            restaurants = fetchResultsController.fetchedObjects as! [Restaurant]
            if result != true {
                print(e?.localizedDescription)
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        /********************************UIPageViewController**********************************************/
        let defaults = NSUserDefaults.standardUserDefaults()
        let hasViewedWalkthrough = defaults.boolForKey("hasViewedWalkthrough")
        if hasViewedWalkthrough == false {
            if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? PageViewController {
            self.presentViewController(pageViewController, animated: false, completion: nil)
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToHomeVIew(segue:UIStoryboardSegue) {
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return restaurants.count
        if searchController.active {
            return searchResults.count
        }else {
            return restaurants.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomTableViewCell
        let restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]

//        let restaurant = restaurants[indexPath.row]
        cell.nameLabel.text = restaurant.name
        cell.typeLabel.text = restaurant.type
        cell.locationLabel.text = restaurant.location
        cell.thumbnailImageView.image = UIImage(data: restaurant.image)
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        cell.thumbnailImageView.clipsToBounds = true
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //            let optionMenu = UIAlertController(title: nil, message: "What do you want?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        //            let handler = { (action:UIAlertAction!) -> Void in
        //            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .Alert)
        //            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        //            self.presentViewController(alertMessage, animated: true, completion: nil)
        //            }
        //
        //            let callAction = UIAlertAction(title: "Call 10086", style: UIAlertActionStyle.Default, handler:handler)
        //            optionMenu.addAction(callAction)
        //
        //            let isVisitedAction = UIAlertAction(title: "I've been here", style: .Default, handler: {
        //                (action:UIAlertAction!) -> Void in
        //                let cell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell
        //                cell.heatIconImage.hidden = false
        //                self.restaurantIsVisited[indexPath.row] = true
        //                })
        //            optionMenu.addAction(isVisitedAction)
        //
        //            self.presentViewController(optionMenu, animated: true, completion: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title:
            "Share", handler: { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
                let shareMenu = UIAlertController(title: nil, message: "Share using",
                    preferredStyle: .ActionSheet)
                let twitterAction = UIAlertAction(title: "Twitter", style:
                    UIAlertActionStyle.Default, handler: nil)
                let facebookAction = UIAlertAction(title: "Facebook", style:
                    UIAlertActionStyle.Default, handler: nil)
                let emailAction = UIAlertAction(title: "Email", style: UIAlertActionStyle.Default,
                    handler: nil)
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel,
                    handler: nil)
                shareMenu.addAction(twitterAction)
                shareMenu.addAction(facebookAction)
                shareMenu.addAction(emailAction)
                shareMenu.addAction(cancelAction)
                self.presentViewController(shareMenu, animated: true, completion: nil)
            }
        )
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default,
            title: "Delete",handler: { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
                
                // Delete the row from the data source
                if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext{
                    let restaurantToDelete = self.fetchResultsController.objectAtIndexPath(indexPath) as! Restaurant
                    managedObjectContext.deleteObject(restaurantToDelete)
//                    var error:NSError?
                    do {
                        try managedObjectContext.save()
                    } catch let error as NSError {
                        print("Delete error: " + error.localizedDescription)

                    }
//                    if managedObjectContext.save() != true {
//                        print("Delete error: " + error!.localizedDescription)
//                    }
                }
                
                
                
//                // Delete the row from the data source
//                self.restaurantNames.removeAtIndex(indexPath.row)
//                self.restaurantLocations.removeAtIndex(indexPath.row)
//                self.restaurantTypes.removeAtIndex(indexPath.row)
//                self.restaurantIsVisited.removeAtIndex(indexPath.row)
//                self.restaurantImages.removeAtIndex(indexPath.row)
//                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } )
        shareAction.backgroundColor = UIColor(red: 255.0/255.0, green: 166.0/255.0, blue:
            51.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue:
            51.0/255.0, alpha: 1.0)
        return [deleteAction, shareAction]
    }
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! DetailViewController
//                destinationController.restaurantImage = self.restaurantImages[indexPath.row]
                destinationController.restaurant = (searchController.active) ? searchResults[indexPath.row] :
                    restaurants[indexPath.row]
//                destinationController.restaurant = restaurants[indexPath.row]
            }
        }
    }
    
    
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        default:
            tableView.reloadData()
        }
        
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
//    func controller(controller: NSFetchedResultsController, didChangeObject anObject: NSManagedObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
//        
//        
//    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
    
    // 检索过滤
    func filterContentSearchText(searchText:String){
        searchResults = restaurants.filter({ ( restaurant: Restaurant) -> Bool in
        let nameMatch = restaurant.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
        let locationMatch = restaurant.location.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
        return nameMatch != nil || locationMatch != nil
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController){
        let searchText = searchController.searchBar.text
        filterContentSearchText(searchText!)
        tableView.reloadData()
    }

}

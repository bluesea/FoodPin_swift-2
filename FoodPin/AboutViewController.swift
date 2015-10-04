//
//  AboutViewController.swift
//  FoodPin
//
//  Created by pingyandong on 15/6/10.
//  Copyright (c) 2015年 Abaobao. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnContact(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            let composer = MFMailComposeViewController()
            composer.delegate = self
            composer.mailComposeDelegate = self
            composer.setToRecipients(["903894198@qq.com"])
            composer.navigationBar.tintColor = UIColor.whiteColor()
            self.presentViewController(composer, animated: true, completion: { () -> Void in
                UIApplication.sharedApplication().statusBarStyle = .LightContent
            })
        }
    }

    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?){
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Saved")
        case MFMailComposeResultSent.rawValue:
            print("Sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail send Failed: \(error!.localizedDescription)")
        default:
            break
        }
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

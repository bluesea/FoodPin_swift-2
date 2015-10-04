//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by pingyandong on 15/6/9.
//  Copyright (c) 2015年 Abaobao. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var backgroundImageView:UIImageView!
    @IBOutlet weak var dialogView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
//        dialogView.transform = CGAffineTransformMakeScale(0.0, 0.0)
//        dialogView.transform = CGAffineTransformMakeTranslation(0, 500)
        let scale = CGAffineTransformMakeScale(0.0, 0.0)
        let translate = CGAffineTransformMakeTranslation(0, 500)
        dialogView.transform = CGAffineTransformConcat(scale, translate)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
//            UIView.animateWithDuration(0.7, delay: 0.0, options: nil, animations: {
//            self.dialogView.transform = CGAffineTransformMakeScale(1, 1)
//            }, completion: nil)
            
            UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.5,
        initialSpringVelocity: 0.5, options: [], animations: {
//        self.dialogView.transform = CGAffineTransformMakeScale(1, 1)
//                    self.dialogView.transform = CGAffineTransformMakeTranslation(0, 0)
            let scale = CGAffineTransformMakeScale(1, 1)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformConcat(scale, translate)
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

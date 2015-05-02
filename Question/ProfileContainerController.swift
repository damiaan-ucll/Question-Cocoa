//
//  ProfileContainerControllerViewController.swift
//  Question
//
//  Created by Damiaan Dufaux on 25/04/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import UIKit
import Meteor

class ProfileContainerController: UITabBarController {

	var userObserver: NSObjectProtocol?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		switchTab()
	}
	
	func switchTab() {
		if Meteor.userID == nil {
			selectedIndex = 1
		} else {
			selectedIndex = 0
		}
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		userObserver = NSNotificationCenter.defaultCenter().addObserverForName(METDDPClientDidChangeAccountNotification, object: Meteor, queue: NSOperationQueue.mainQueue()) {
			_ in
			self.switchTab()
		}
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

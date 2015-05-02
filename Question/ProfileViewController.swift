//
//  ProfileViewController.swift
//  Question
//
//  Created by Damiaan Dufaux on 25/04/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

	@IBAction func logout(sender: AnyObject) {
		Meteor.logoutWithCompletionHandler {
			error in
			println("error: \(error)")
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

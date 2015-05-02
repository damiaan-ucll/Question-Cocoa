//
//  SecondViewController.swift
//  Question
//
//  Created by Damiaan Dufaux on 24/04/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import UIKit
import Meteor

class LoginViewController: UIViewController {

	@IBOutlet var usernameField: UITextField!
	@IBOutlet var passwordField: UITextField!
	
	@IBAction func login(sender: AnyObject) {
		let username = usernameField.text
		let password = passwordField.text
		Meteor.loginWithName(username, password: password) {
			error in
			if let error = error {
				println(error)
				UIAlertView(title: "Error while logging in", message: error.localizedFailureReason, delegate: nil, cancelButtonTitle: "Try again").show()
			} else {
				println("logged in succesfull")
			}
		}
	}
	
	@IBAction func logout(sender: AnyObject) {
		Meteor.logoutWithCompletionHandler {
			error in
			if let error = error {
				println("error while logging out, \(error)")
				UIAlertView(title: "Error while logging out", message: error.localizedFailureReason, delegate: nil, cancelButtonTitle: "Try again").show()
			} else {
				println("logged out succesfull")
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		NSNotificationCenter.defaultCenter().addObserverForName(METDDPClientDidChangeAccountNotification , object: Meteor, queue: NSOperationQueue.mainQueue()) {
			_ in
			if Meteor.userID == nil {
				
			} else {

			}
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		
		
	}

}
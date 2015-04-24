//
//  FirstViewController.swift
//  Question
//
//  Created by Damiaan Dufaux on 24/04/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import UIKit
import Meteor

class FirstViewController: UIViewController {
	@IBOutlet var titleLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		let subscriptionLoader = SubscriptionLoader()
		
		let notificationCenter = NSNotificationCenter.defaultCenter()
		notificationCenter.addObserverForName(METDDPClientDidChangeConnectionStatusNotification, object: nil, queue: NSOperationQueue.mainQueue()) { _ in
			if Meteor.connected {
				let q: AnyObject! = Meteor.callMethodWithName("getUnreadQuestion", parameters: []) {
					questionId, error in
					
					subscriptionLoader.addSubscriptionWithName("questionById", parameters: questionId)
					
					subscriptionLoader.whenReady {
						
						let questionOID = Meteor.objectIDForDocumentKey(METDocumentKey(collectionName: "questions", documentID: questionId))
						
						var question = Meteor.mainQueueManagedObjectContext.existingObjectWithID(questionOID, error: nil) as? Question
						
						if let question = question {
							self.titleLabel.text = question.content
						}
					}
				}
			}
		}

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}


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
	@IBOutlet var pieChart: XYPieChart!
	
	var question: Question?
	var viewedQuestions = 0
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		whenConnected {
			self.loadNextQuestion()
		}

		pieChart.dataSource = self
		pieChart.labelColor = UIColor.whiteColor()
	}

	@IBAction func shrinkPie(sender: AnyObject) {
		pieChart.pieRadius = 3
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		pieChart.reloadData()
	}
	
	override func viewWillAppear(animated: Bool) {
		loadNextQuestion()
	}
	
	@IBAction func skipQuestion(sender: AnyObject) {
		Meteor.callMethodWithName("skipQuestion", parameters: [Meteor.documentKeyForObjectID(question?.objectID).documentID]) {
			_ in
			self.loadNextQuestion()
		}
	}
	
	func loadNextQuestion() {
		viewedQuestions++
		if (viewedQuestions-1 % 6 == 5) {
			
			titleLabel.text = "Do you want to ask a question?"
			
		} else {
			let subscriptionLoader = SubscriptionLoader()
			
			Meteor.callMethodWithName("getUnreadQuestion", parameters: []) {
				questionId, error in
				
				subscriptionLoader.addSubscriptionWithName("questionById", parameters: questionId)
				subscriptionLoader.whenReady {
					
					let questionOID = Meteor.objectIDForDocumentKey(METDocumentKey(collectionName: "questions", documentID: questionId))
					
					var question = Meteor.mainQueueManagedObjectContext.existingObjectWithID(questionOID, error: nil) as? Question
					
					if let question = question {
						println(question)
						self.question = question
						self.titleLabel.text = question.content
					}
				}
			}
		}
		
	}
	
	func whenConnected(callback: ()->()) {
		let notificationCenter = NSNotificationCenter.defaultCenter()
		var listener: NSObjectProtocol!
		var handler: (NSNotification!) -> Void = { _ in
			
			if Meteor.connected {
				callback()
				notificationCenter.removeObserver(listener)
			}
			
		}
		listener = notificationCenter.addObserverForName(METDDPClientDidChangeConnectionStatusNotification, object: Meteor, queue: NSOperationQueue.mainQueue(), usingBlock: handler)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension FirstViewController: XYPieChartDataSource {
	func numberOfSlicesInPieChart(pieChart: XYPieChart!) -> UInt {
		return 3
	}
	
	func pieChart(pieChart: XYPieChart!, valueForSliceAtIndex index: UInt) -> CGFloat {
		return CGFloat(index+1)
	}
}


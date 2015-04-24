//
//  Question.swift
//  Question
//
//  Created by Damiaan Dufaux on 24/04/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Foundation
import CoreData

@objc(Question)
class Question: NSManagedObject {

    @NSManaged var content: String
	
	override var description: String {
		return content;
	}

}

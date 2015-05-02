//
//  Answer.swift
//  Question
//
//  Created by Damiaan Dufaux on 24/04/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Foundation
import CoreData

@objc(Answer)
class Answer: NSManagedObject {

    @NSManaged var answer: NSNumber
    @NSManaged var user: User
    @NSManaged var question: Question

}

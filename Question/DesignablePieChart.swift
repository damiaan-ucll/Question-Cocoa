//
//  test.swift
//  Question
//
//  Created by Damiaan Dufaux on 26/04/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import UIKit

class PieData: NSObject, XYPieChartDataSource {
	func numberOfSlicesInPieChart(pieChart: XYPieChart!) -> UInt {
		return 4
	}
	
	func pieChart(pieChart: XYPieChart!, valueForSliceAtIndex index: UInt) -> CGFloat {
		return CGFloat(index+1)
	}
}

@IBDesignable class DesignablePieChart : XYPieChart {
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		dataSource = PieData()
		reloadData()
	}
		
}

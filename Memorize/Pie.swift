//
//  Pie.swift
//  Memorize
//
//  Created by Valentin Purrucker on 02.02.22.
//

import SwiftUI



struct Pie: Shape {
	
	let startAngle: Angle
	let endAngle: Angle
	var clockwise = false
	
	func path(in rect: CGRect) -> Path {
		var path = Path()
		let center = CGPoint(x: rect.midX, y: rect.midY)
		let radius = min(rect.width, rect.height) / 2
		let start = CGPoint(
			x: center.x + radius * cos(startAngle.radians),
			y: center.y + radius * sin(startAngle.radians)
		)
		
		
		path.move(to: center)
		path.addLine(to: start)
		path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
		path.addLine(to: center)
		
		return path
	}
}

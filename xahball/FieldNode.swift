//
//  FieldNode.swift
//  xahball
//
//  Created by Bergman, Yon on 7/29/15.
//  Copyright (c) 2015 yonbergman. All rights reserved.
//

import SpriteKit

class FieldNode {
  static let marginX: CGFloat = 50
  static let marginY: CGFloat = 30
  static let fieldLineWidth: CGFloat = 2
  static let circleRadius: CGFloat = 70
  
  static let goalHeight: CGFloat = 133
  static let goalWidth: CGFloat = 30
  
  static let goalPostSize: CGFloat = 9
  
  class func createField(frame: CGRect) -> SKShapeNode {

    let goalYDiff = (frame.height - (marginY*2) - goalHeight) / 2
    let path = UIBezierPath()
    path.moveToPoint(CGPoint(x: marginX, y: marginY))
    path.addLineToPoint(CGPoint(x: frame.maxX - marginX, y: marginY))
    path.addLineToPoint(CGPoint(x: frame.maxX - marginX, y: marginY + goalYDiff))
    
    path.addQuadCurveToPoint(CGPoint(x: frame.maxX - marginX + goalWidth, y: marginY + goalYDiff + 20),
      controlPoint: CGPoint(x: frame.maxX - marginX + goalWidth, y: marginY + goalYDiff))
    
    path.addLineToPoint(CGPoint(x: frame.maxX - marginX + goalWidth, y: frame.maxY - marginY - goalYDiff - 20))
    
    path.addQuadCurveToPoint(CGPoint(x: frame.maxX - marginX, y: frame.maxY - marginY - goalYDiff),
                      controlPoint: CGPoint(x: frame.maxX - marginX + goalWidth, y: frame.maxY - marginY - goalYDiff))

    path.addLineToPoint(CGPoint(x: frame.maxX - marginX, y: frame.maxY - marginY - goalYDiff))
    path.addLineToPoint(CGPoint(x: frame.maxX - marginX, y: frame.maxY - marginY))
    path.addLineToPoint(CGPoint(x: marginX, y: frame.maxY - marginY))
    path.addLineToPoint(CGPoint(x: marginX, y: frame.maxY - marginY - goalYDiff))
    
    path.addQuadCurveToPoint(CGPoint(x: marginX - goalWidth, y: frame.maxY - marginY - goalYDiff - 20),
      controlPoint: CGPoint(x: marginX - goalWidth, y: frame.maxY - marginY - goalYDiff))
    
    path.addLineToPoint(CGPoint(x: marginX - goalWidth, y: marginY + goalYDiff + 20))

    path.addQuadCurveToPoint(CGPoint(x: marginX, y: marginY + goalYDiff),
      controlPoint: CGPoint(x: marginX - goalWidth, y: marginY + goalYDiff))
    path.addLineToPoint(CGPoint(x: marginX, y: marginY+1))
    path.closePath()
    
    
    let rect = frame.rectByInsetting(dx: marginX, dy: marginY)

    let field = SKShapeNode(rect: rect)
    
    field.strokeColor = fieldLineColor
    field.lineWidth = fieldLineWidth
    field.physicsBody = SKPhysicsBody(edgeChainFromPath: path.CGPath)
    field.physicsBody?.friction = 0
    field.fillColor = fieldColor
    
    
    let line = SKShapeNode(rect: CGRect(x: rect.midX, y: rect.minY, width: 0, height: rect.height))
    line.strokeColor = fieldLineColor
    line.lineWidth = fieldLineWidth
    field.addChild(line)
    
    let circle = SKShapeNode(ellipseInRect: CGRect(x: rect.midX, y: rect.midY, width: circleRadius * 2, height: circleRadius * 2).rectByOffsetting(dx: -circleRadius, dy: -circleRadius))
    circle.strokeColor = fieldLineColor
    circle.lineWidth = fieldLineWidth
    field.addChild(circle)
    
    
    let leftGoal = createGoal(frame, isLeft: true)
    field.addChild(leftGoal)

    let rightGoal = createGoal(frame, isLeft: false)
    field.addChild(rightGoal)


    return field
  }
  
  class func createGoal(frame: CGRect, isLeft: Bool) -> SKShapeNode {
    
    var children:[SKNode] = []
    let path = UIBezierPath()
    let goalYDiff = (frame.height - (marginY*2) - goalHeight) / 2
    
    if isLeft {
      let pointA = CGPoint(x: marginX, y: frame.maxY - marginY - goalYDiff)
      path.moveToPoint(pointA)
      
      path.addQuadCurveToPoint(CGPoint(x: marginX - goalWidth, y: frame.maxY - marginY - goalYDiff - 20),
        controlPoint: CGPoint(x: marginX - goalWidth, y: frame.maxY - marginY - goalYDiff))
      
      path.addLineToPoint(CGPoint(x: marginX - goalWidth, y: marginY + goalYDiff + 20))
      
      let pointB = CGPoint(x: marginX, y: marginY + goalYDiff)
      path.addQuadCurveToPoint(pointB,
        controlPoint: CGPoint(x: marginX - goalWidth, y: marginY + goalYDiff))

      
      children.append(createGoalPost(pointA))
      children.append(createGoalPost(pointB))
    
    } else {
      let pointA = CGPoint(x: frame.maxX - marginX, y: marginY + goalYDiff)
      path.moveToPoint(pointA)
      
      path.addQuadCurveToPoint(CGPoint(x: frame.maxX - marginX + goalWidth, y: marginY + goalYDiff + 20),
        controlPoint: CGPoint(x: frame.maxX - marginX + goalWidth, y: marginY + goalYDiff))
      
      path.addLineToPoint(CGPoint(x: frame.maxX - marginX + goalWidth, y: frame.maxY - marginY - goalYDiff - 20))
      
      let pointB = CGPoint(x: frame.maxX - marginX, y: frame.maxY - marginY - goalYDiff)
      path.addQuadCurveToPoint(pointB,
        controlPoint: CGPoint(x: frame.maxX - marginX + goalWidth, y: frame.maxY - marginY - goalYDiff))
      
      children.append(createGoalPost(pointA))
      children.append(createGoalPost(pointB))

    }
    
    let node = SKShapeNode(path: path.CGPath)
    node.strokeColor = UIColor.blackColor()
    node.lineWidth = 2
    for subNode in children {
      node.addChild(subNode)
    }
    return node
  }
  
  class func createGoalPost(point: CGPoint) -> SKShapeNode {
    let goalPost = SKShapeNode(circleOfRadius: goalPostSize)
    goalPost.fillColor = goalPostColor
    goalPost.lineWidth = 2
    goalPost.strokeColor = UIColor.blackColor()
    goalPost.physicsBody = SKPhysicsBody(circleOfRadius: goalPostSize + 2)
    goalPost.physicsBody?.dynamic = false
    
    goalPost.position = point
    return goalPost
  }
  
  
}
//
//  BallNode.swift
//  xahball
//
//  Created by Bergman, Yon on 7/29/15.
//  Copyright (c) 2015 yonbergman. All rights reserved.
//

import SpriteKit

class BallNode: SKShapeNode {
  static let circleSize: CGFloat = 8
  static let strokeWidth: CGFloat = 2
  
  override init() {
    super.init()
    path = UIBezierPath(ovalInRect: CGRect(x: -BallNode.circleSize, y: -BallNode.circleSize, width: BallNode.circleSize * 2, height: BallNode.circleSize * 2)).CGPath
    fillColor = UIColor.whiteColor()
    strokeColor = UIColor.blackColor()
    lineWidth = BallNode.strokeWidth
    physicsBody = SKPhysicsBody(circleOfRadius: BallNode.circleSize + BallNode.strokeWidth)
    physicsBody?.allowsRotation = false
    physicsBody?.mass = 0.1
    physicsBody?.restitution = 0.5
    physicsBody?.linearDamping = 0
    physicsBody?.angularDamping = 0
    physicsBody?.categoryBitMask = ballCollision
    physicsBody?.collisionBitMask = allCollision | ballBoundsCollision
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
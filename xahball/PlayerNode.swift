//
//  PlayerNode.swift
//  xahball
//
//  Created by Bergman, Yon on 7/29/15.
//  Copyright (c) 2015 yonbergman. All rights reserved.
//

import SpriteKit

class PlayerNode: SKShapeNode {
  static let circleSize: CGFloat = 12
  static let strokeWidth: CGFloat = 2
  static let fontSize: CGFloat = 12
  static let kickSize: CGFloat = 10
  
  static let kickCircle: CGFloat = kickSize + circleSize
  
  
  var kickCircle: SKShapeNode!
  var arrow: SKShapeNode!
  
  init(player: Player) {
    super.init()
    path = UIBezierPath(ovalInRect: CGRect(x: -PlayerNode.circleSize, y: -PlayerNode.circleSize, width: PlayerNode.circleSize * 2, height: PlayerNode.circleSize * 2)).CGPath
    strokeColor = UIColor.blackColor()
    lineWidth = PlayerNode.strokeWidth
    physicsBody = SKPhysicsBody(circleOfRadius: PlayerNode.circleSize + PlayerNode.strokeWidth)
    physicsBody?.allowsRotation = false
    physicsBody?.mass = 1
    physicsBody?.restitution = 0.4
    
    fillColor = player.team.type.color
    
    let label = SKLabelNode(fontNamed: "Helvetica-Bold")
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
    label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
    label.fontSize = PlayerNode.fontSize
    label.color = UIColor.whiteColor()
    label.text = player.avatar
    addChild(label)

    
    if !player.activePlayer {
      let nameLabel = SKLabelNode(fontNamed: "Helvetica-Regular")
      nameLabel.text = player.name
      nameLabel.fontSize = PlayerNode.fontSize
      nameLabel.color = UIColor.whiteColor()
      nameLabel.position = CGPoint(x: 0, y: -(PlayerNode.circleSize*2))
      addChild(nameLabel)
    }

    
    if player.activePlayer {
      let arrowPath = UIBezierPath()
      arrowPath.moveToPoint(CGPoint(x:-3, y: PlayerNode.circleSize + PlayerNode.strokeWidth))
      arrowPath.addLineToPoint(CGPoint(x: 0, y: PlayerNode.circleSize + PlayerNode.strokeWidth + 7))
      arrowPath.addLineToPoint(CGPoint(x: 3, y: PlayerNode.circleSize + PlayerNode.strokeWidth))
      arrowPath.closePath()
      let arrowSprite = SKShapeNode(path: arrowPath.CGPath)
      arrowSprite.strokeColor = UIColor.clearColor()
      arrowSprite.fillColor = UIColor.whiteColor().colorWithAlphaComponent(0.8)
      addChild(arrowSprite)
      arrow = arrowSprite
      
      let largerSprite = SKShapeNode(circleOfRadius: PlayerNode.kickCircle)
      largerSprite.strokeColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
      largerSprite.lineWidth = PlayerNode.strokeWidth
      largerSprite.fillColor = UIColor.clearColor()
      kickCircle = largerSprite
      addChild(largerSprite)
    }

  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func updateArrow() {
    if let arrow = arrow {
      let angle = atan2(-physicsBody!.velocity.dx, physicsBody!.velocity.dy)
      arrow.zRotation = angle
    }
  }
  
  func kick() {
    let delayTime: NSTimeInterval = 0.1
    let action = SKAction.customActionWithDuration(0, actionBlock: { (node, elapsedTime) -> Void in
      (node as! SKShapeNode).strokeColor = UIColor.whiteColor()
    })
    let delayAction = SKAction.waitForDuration(delayTime)

    let reversedAction = SKAction.customActionWithDuration(0, actionBlock: { (node, elapsedTime) -> Void in
      (node as! SKShapeNode).strokeColor = UIColor.blackColor()
    })
    let kickAction = SKAction.sequence([action, delayAction, reversedAction])
    runAction(kickAction)
  }  
  
}
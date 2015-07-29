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
  static let fontSize: CGFloat = 16
  static let kickSize: CGFloat = 10
  
  static let kickCircle: CGFloat = kickSize + circleSize
  
  
  var kickCircle: SKShapeNode!
  
  init(player: Player) {
    super.init()
    path = UIBezierPath(ovalInRect: CGRect(x: -PlayerNode.circleSize, y: -PlayerNode.circleSize, width: PlayerNode.circleSize * 2, height: PlayerNode.circleSize * 2)).CGPath
    strokeColor = UIColor.blackColor()
    lineWidth = PlayerNode.strokeWidth
    physicsBody = SKPhysicsBody(circleOfRadius: PlayerNode.circleSize + PlayerNode.strokeWidth)
    physicsBody?.allowsRotation = false
    physicsBody?.mass = 1
    
    if player.team.type == .Red {
      fillColor = redTeamColor
    } else {
      fillColor = blueTeamColor
    }
    
    let label = SKLabelNode(fontNamed: "Helvetica-Bold")
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
    label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
    label.fontSize = PlayerNode.fontSize
    label.color = UIColor.whiteColor()
    label.text = (random() % 100).description
    
    let largerSprite = SKShapeNode(circleOfRadius: PlayerNode.kickCircle)
    largerSprite.strokeColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
    largerSprite.lineWidth = PlayerNode.strokeWidth
    largerSprite.fillColor = UIColor.clearColor()
    kickCircle = largerSprite
    
    addChild(largerSprite)
    addChild(label)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
}
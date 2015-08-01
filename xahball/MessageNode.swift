//
//  MessageNode.swift
//  xahball
//
//  Created by Bergman, Yon on 8/1/15.
//  Copyright (c) 2015 yonbergman. All rights reserved.
//

import SpriteKit


class MessageNode: SKNode {
  
  let shadowNode: SKLabelNode
  let textNode: SKLabelNode
  let fontSize: CGFloat = 50
  let parentFrame: CGRect
  
  init(frame: CGRect) {

    self.parentFrame = frame
    
    shadowNode = SKLabelNode(fontNamed: "Helvetica-Bold")
    shadowNode.color = SKColor.blackColor()
    shadowNode.fontSize = fontSize
    shadowNode.colorBlendFactor = 1

    textNode = SKLabelNode(fontNamed: "Helvetica-Bold")
    textNode.color = SKColor.blackColor()
    textNode.fontSize = fontSize
    textNode.colorBlendFactor = 1
    textNode.position = CGPoint(x: -3, y: 3)
    
    super.init()
    addChild(shadowNode)
    addChild(textNode)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func showMessage(message: String, color: SKColor) {
    shadowNode.text = message
    textNode.text = message
    textNode.color = color
    
    let moveAction = SKAction.moveToX(parentFrame.midX, duration: 0.7)
    let fadeAction = SKAction.fadeInWithDuration(0.5)
    let textAction = SKAction.group([moveAction, fadeAction])
    let actions = SKAction.sequence([textAction, SKAction.waitForDuration(0.7), SKAction.fadeOutWithDuration(0.3)])
    alpha = 0
    position = CGPoint(x: parentFrame.midX / 2, y: parentFrame.midY)
    runAction(actions)

  }
}
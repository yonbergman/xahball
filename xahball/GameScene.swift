//
//  GameScene.swift
//  xahball
//
//  Created by Bergman, Yon on 7/22/15.
//  Copyright (c) 2015 yonbergman. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  
  var didCreate = false
  
  var ball: BallNode!
  var player1: PlayerNode!
  var player2: PlayerNode!
  
  var message: MessageNode!
  
  var activePlayer: PlayerNode!
  
  var justScored = false
  
  func createScene() {
    physicsWorld.gravity = CGVectorMake(0, 0)
    
    addChild(FieldNode.createField(self.frame))

    ball = BallNode()
    ball.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
    addChild(ball)
    
    let player = Player(team: Team(type: .Red), name: "Yonatan", activePlayer: true)
    player.avatar = "YB"
    player1 = PlayerNode(player: player)
    player1.position = CGPoint(x: self.frame.minX + 100, y: self.frame.midY)
    addChild(player1)
    activePlayer = player1

    
    player2 = PlayerNode(player: Player(team: Team(type: .Blue), name: nil))
    player2.position = CGPoint(x: self.frame.maxX - 100, y: self.frame.midY + 100)
    addChild(player2)
    
    message = MessageNode(frame: frame)
    addChild(message)
    
  }
  
  override func didMoveToView(view: SKView) {
    if !didCreate {
      createScene()
    }
  }
  
  override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
    for touch in (touches as! Set<UITouch>) {
      let location = touch.locationInNode(self)
      let previousLocation = touch.previousLocationInNode(self)
      activePlayer.physicsBody?.applyImpulse(CGVector(dx: location.x - previousLocation.x, dy: location.y - previousLocation.y))
    }
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    if event.touchesForView(view!)!.count == 2 {
      let distance = hypot(ball.position.x - player1.position.x, ball.position.y - player1.position.y)
      activePlayer.kick()
      if distance <= 32 {
        ball.physicsBody?.applyImpulse(CGVector(dx: ball.frame.midX - player1.frame.midX, dy: ball.frame.midY - player1.frame.midY))
      }
    }
  }
  
  override func update(currentTime: CFTimeInterval) {
    if ball.position.x <= FieldNode.marginX {
      goal(.Blue)
    } else if ball.position.x >= frame.maxX - FieldNode.marginX {
      goal(.Red)
    }
    
    activePlayer.updateArrow()
  }
  
  private func goal(team: TeamType) {
    if justScored { return }
    justScored = true
    let wait = SKAction.waitForDuration(1)
    let do2 = SKAction.customActionWithDuration(0, actionBlock: { (node, elapsedTime) -> Void in
      self.reset()
    })
    let actions = SKAction.sequence([wait, do2])
    self.runAction(actions)

    message.showMessage("\(team.name) Scored!", color: team.color)
  }
  
  private func reset() {
    justScored = false
    ball.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
    ball.physicsBody?.resting = true
    
    player1.position = CGPoint(x: self.frame.minX + 100, y: self.frame.midY)
    player1.physicsBody?.resting = true
    
    player2.position = CGPoint(x: self.frame.maxX - 100, y: self.frame.midY)
    player2.physicsBody?.resting = true

  }
  
}

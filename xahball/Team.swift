//
//  Team.swift
//  xahball
//
//  Created by Bergman, Yon on 7/29/15.
//  Copyright (c) 2015 yonbergman. All rights reserved.
//

import Foundation
import SpriteKit

class Player {
  var name: String
  let team: Team
  let activePlayer: Bool
  var avatar: String
  
  init(team: Team, name: String?, activePlayer: Bool = false) {
    self.team = team
    self.name = name ?? "Bot"
    self.avatar = (random() % 100).description
    self.activePlayer = activePlayer
  }
  
}

enum TeamType: String {
  case Blue = "Blue", Red = "Red"
  
  var name: String {
    return rawValue
  }
  
  var color: SKColor {
    return self == .Blue ? blueTeamColor : redTeamColor
  }
}

class Team {
  
  let players: [Player] = []
  let type: TeamType
  
  init(type: TeamType) {
    self.type = type
  }
}

class Game {
  let teamOne = Team(type: .Blue)
  let teamTwo = Team(type: .Red)
}
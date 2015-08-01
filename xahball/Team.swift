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
    team.players.append(self)
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
  
  var players: [Player] = []
  let type: TeamType
  var score = 0
  
  init(type: TeamType) {
    self.type = type
  }
  
  func scored() -> Int {
    score += 1
    return score
  }
}

enum GoalType {
  case MidGame, Winning
  
  func message(teamType: TeamType) -> String {
    switch self {
      case .MidGame: return "\(teamType.name) Scored!"
      case .Winning: return "\(teamType.name) Won!"
    }
  }
}
class Game {
  
  let targetTime = NSTimeInterval(5 * 60)
  let targetScore = 5
  let redTeam = Team(type: .Red)
  let blueTeam = Team(type: .Blue)
  
  func score(teamType: TeamType) -> GoalType{
    let team = teamType == .Blue ? blueTeam : redTeam
    if team.scored() >= targetScore {
      return .Winning
    } else {
      return .MidGame
    }
  }
}
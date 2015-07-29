//
//  Team.swift
//  xahball
//
//  Created by Bergman, Yon on 7/29/15.
//  Copyright (c) 2015 yonbergman. All rights reserved.
//

import Foundation

class Player {
  var name: String?
  let team: Team
  
  init(team: Team, name: String?) {
    self.team = team
    self.name = name
  }
}

enum TeamType {
  case Blue, Red
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
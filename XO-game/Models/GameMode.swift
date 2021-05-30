//
//  GameMode.swift
//  XO-game
//
//  Created by Alexander Andrianov on 28.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

enum GameMode: CaseIterable {
  case twoPlayers, playerVersusNPC, fiveToFive
}

extension GameMode {
  var strategy: GameStrategy {
    switch self {
    case .twoPlayers:
      return TwoPlayersStrategy()
    case .playerVersusNPC:
      return PlayerVersusNPCStrategy()
    case .fiveToFive:
      return FiveToFiveStrategy()
    }
  }
}

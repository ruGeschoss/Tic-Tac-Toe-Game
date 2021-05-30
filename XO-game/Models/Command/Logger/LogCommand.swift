//
//  LogCommand.swift
//  XO-game
//
//  Created by Alexander Andrianov on 27.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

final class LogCommand {
  
  let action: LogAction
  
  init(action: LogAction) {
    self.action = action
  }
  
  var logMessage: String {
    switch action {
    case .playerInput(let player, let position):
      return "\(player) player placed mark at \(position)"
    case .gameFinished(let winner):
      if let winner = winner {
        return "\(winner) player won game"
      } else {
        return "game finished with draw"
      }
    case .restartGame:
      return "game restarted"
    }
  }
}

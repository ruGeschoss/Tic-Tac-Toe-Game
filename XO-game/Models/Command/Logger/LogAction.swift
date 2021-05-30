//
//  LogAction.swift
//  XO-game
//
//  Created by Alexander Andrianov on 27.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

enum LogAction {
  case playerInput(player: Player, position: GameboardPosition)
  case gameFinished(winner: Player?)
  case restartGame
}

func log(_ action: LogAction) {
  let command = LogCommand(action: action)
  LoggerInvoker.shared.addLogCommand(command)
}

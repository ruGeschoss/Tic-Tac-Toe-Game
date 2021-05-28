//
//  GameEndedState.swift
//  XO-game
//
//  Created by Alexander Andrianov on 27.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

final class GameEndedState: GameState {
  
  let isCompleted = false
  
  let winner: Player?
  private(set) weak var gameViewController: GameViewController?
  
  init(winner: Player?, gameViewController: GameViewController) {
    self.winner = winner
    self.gameViewController = gameViewController
  }
  
  func begin() {
    gameViewController?.winnerLabel.isHidden = false
    log(.gameFinished(winner: winner))
    
    if let winner = winner {
      gameViewController?.winnerLabel.text = winnerName(from: winner) + " won"
    } else {
      gameViewController?.winnerLabel.text = "Draw!"
    }
    gameViewController?.firstPlayerTurnLabel.isHidden = true
    gameViewController?.secondPlayerTurnLabel.isHidden = true
  }
  
  func addMark(at position: GameboardPosition) { }
  
  private func winnerName(from winner: Player) -> String {
    switch winner {
    case .first:
      return "1st player"
    case .second:
      return "2nd player"
    }
  }
}

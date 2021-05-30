//
//  FiveToFiveStratagy.swift
//  XO-game
//
//  Created by Alexander Andrianov on 28.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class FiveToFiveStrategy: GameStrategy {
  
  func setNextState(currentState: inout GameState,
                    gameboard: Gameboard,
                    gameboardView: inout GameboardView,
                    gameViewController: GameViewController) {
    switch currentState {
    case is FiveToFiveInputState:
      if let inputState = currentState as? FiveToFiveInputState,
         inputState.player == .first {
        let secondPlayer = inputState.player.next
        currentState = FiveToFiveInputState(player: secondPlayer,
                                            markViewPrototype: secondPlayer.markViewPrototype,
                                            gameViewController: gameViewController,
                                            gameboard: gameboard,
                                            gameboardView: gameboardView)
      } else {
        currentState = FiveToFiveExecutionState(gameViewController: gameViewController,
                                                gameboard: gameboard,
                                                gameboardView: gameboardView)
      }
    default:
      let winner = gameViewController.referee.determineWinner()
      currentState = GameEndedState(winner: winner,
                                    gameViewController: gameViewController)
    }
  }
  
  func setFirstState(gameboard: Gameboard,
                     gameboardView: inout GameboardView,
                     gameViewController: GameViewController) -> GameState {
    let firstPlayer = Player.first
    let firstState = FiveToFiveInputState(player: firstPlayer,
                                          markViewPrototype: firstPlayer.markViewPrototype,
                                          gameViewController: gameViewController,
                                          gameboard: gameboard,
                                          gameboardView: gameboardView)
    return firstState
  }
  
}

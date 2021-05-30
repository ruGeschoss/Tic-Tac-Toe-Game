//
//  GameStrategy.swift
//  XO-game
//
//  Created by Alexander Andrianov on 28.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

protocol GameStrategy {
  
  func setFirstState(gameboard: Gameboard,
                     gameboardView: inout GameboardView,
                     gameViewController: GameViewController) -> GameState
  
  func setNextState(currentState: inout GameState,
                    gameboard: Gameboard,
                    gameboardView: inout GameboardView,
                    gameViewController: GameViewController)
}

extension GameStrategy {
  
  func setFirstState(gameboard: Gameboard,
                     gameboardView: inout GameboardView,
                     gameViewController: GameViewController) -> GameState {
    let player = Player.first
    return PlayerInputState(player: player,
                                    markViewPrototype: player.markViewPrototype,
                                    gameViewController: gameViewController,
                                    gameboard: gameboard,
                                    gameboardView: gameboardView)
  }
  
}

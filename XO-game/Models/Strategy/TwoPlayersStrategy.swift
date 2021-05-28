//
//  TwoPlayersStrategy.swift
//  XO-game
//
//  Created by Alexander Andrianov on 28.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class TwoPlayersStrategy: GameStrategy {
  
  func setNextState(currentState: inout GameState,
                    gameboard: Gameboard,
                    gameboardView: inout GameboardView,
                    gameViewController: GameViewController) {
    
    guard let playerInputState = currentState as? PlayerInputState else { return }
    
    let player = playerInputState.player.next
    currentState = PlayerInputState(player: player,
                                    markViewPrototype: player.markViewPrototype,
                                    gameViewController: gameViewController,
                                    gameboard: gameboard,
                                    gameboardView: gameboardView)
    
  }
}

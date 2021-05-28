//
//  GameStrategy.swift
//  XO-game
//
//  Created by Alexander Andrianov on 28.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

protocol GameStrategy {
  func setNextState(currentState: inout GameState,
                    gameboard: Gameboard,
                    gameboardView: inout GameboardView,
                    gameViewController: GameViewController)
}

// MARK: - Player VS Player
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

// MARK: - Player VS NPC
class PlayerVersusNPCStrategy: GameStrategy {
  
  func setNextState(currentState: inout GameState,
                    gameboard: Gameboard,
                    gameboardView: inout GameboardView,
                    gameViewController: GameViewController) {
    
    if currentState is PlayerInputState {
      let player = Player.npc
      currentState = NPCInputState(player: player,
                                   markViewPrototype: player.markViewPrototype,
                                   gameViewController: gameViewController,
                                   gameboard: gameboard,
                                   gameboardView: gameboardView)
      return
    } else {
      guard currentState is NPCInputState else { return }
      
      let player = Player.first
      currentState = PlayerInputState(player: player,
                                      markViewPrototype: player.markViewPrototype,
                                      gameViewController: gameViewController,
                                      gameboard: gameboard,
                                      gameboardView: gameboardView)
      return
    }
  }
}

// MARK: - Five to Five
//  class fiveToFiveStrategy: GameStrategy {
//    func setNextState() {
//      <#code#>
//    }
//  }

//
//  FiveToFiveInputState.swift
//  XO-game
//
//  Created by Alexander Andrianov on 29.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

final class FiveToFiveInputState: GameState {
  
  private enum Constants {
    static let maximMarksForPlayer: Int = 5
  }
  
  private(set) var isCompleted = false
  
  let player: Player
  let markViewPrototype: MarkView
  private(set) weak var gameViewController: GameViewController?
  private(set) weak var gameboard: Gameboard?
  private(set) weak var gameboardView: GameboardView?
  
  init(player: Player,
       markViewPrototype: MarkView,
       gameViewController: GameViewController,
       gameboard: Gameboard,
       gameboardView: GameboardView) {
    
    self.player = player
    self.markViewPrototype = markViewPrototype
    self.gameViewController = gameViewController
    self.gameboard = gameboard
    self.gameboardView = gameboardView
  }
  
  func begin() {
    switch player {
    case .first:
      gameViewController?.firstPlayerTurnLabel.isHidden = false
      gameViewController?.secondPlayerTurnLabel.isHidden = true
    case .second, .npc:
      gameViewController?.firstPlayerTurnLabel.isHidden = true
      gameViewController?.secondPlayerTurnLabel.isHidden = false
    }
    gameViewController?.winnerLabel.isHidden = true
  }
  
  func addMark(at position: GameboardPosition) {
    guard
      let gameboardView = gameboardView,
      gameboardView.canPlaceMarkView(at: position),
      let invoker = gameViewController?.commandInvoker
    else { return }
    
    gameboardView.placeMarkView(player.markViewPrototype, at: position)
      invoker.addCommand(player: player,
                                                  position: position)
    if invoker.allCommands.count % Constants.maximMarksForPlayer == 0 {
      gameboardView.clear()
      isCompleted = true
    }
  }
  
}

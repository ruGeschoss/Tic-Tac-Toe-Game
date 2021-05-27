//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Alexander Andrianov on 27.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

final class PlayerInputState: GameState {
  
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
    case .second:
      gameViewController?.firstPlayerTurnLabel.isHidden = true
      gameViewController?.secondPlayerTurnLabel.isHidden = false
    }
    gameViewController?.winnerLabel.isHidden = true
  }
  
  func addMark(at position: GameboardPosition) {
    guard
      let gameboardView = gameboardView,
      gameboardView.canPlaceMarkView(at: position)
    else { return }
    
    gameboard?.setPlayer(player, at: position)
    gameboardView.placeMarkView(markViewPrototype.copy(), at: position)
    log(.playerInput(player: player, position: position))
    isCompleted = true
  }
}

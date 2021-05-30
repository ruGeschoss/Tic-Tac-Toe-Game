//
//  NPCInputState.swift
//  XO-game
//
//  Created by Alexander Andrianov on 28.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

final class NPCInputState: GameState {
  
  private enum Constants {
    static let npcTurnLabelText = "NPC"
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
    gameViewController?.firstPlayerTurnLabel.isHidden = true
    gameViewController?.secondPlayerTurnLabel.text = Constants.npcTurnLabelText
    gameViewController?.secondPlayerTurnLabel.isHidden = false
    gameViewController?.winnerLabel.isHidden = true
    gameViewController?.gameboardView.isUserInteractionEnabled = false
    
    guard
      let position = gameboard?.getEmptyPositions().randomElement()
    else { return }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.gameboardView?.onSelectPosition!(position)
    }
  }
  
  func addMark(at position: GameboardPosition) {
    gameboard?.setPlayer(player, at: position)
    gameboardView?.placeMarkView(markViewPrototype.copy(), at: position)
    log(.playerInput(player: player, position: position))
    isCompleted = true
    gameViewController?.gameboardView.isUserInteractionEnabled = true
  }
  
}

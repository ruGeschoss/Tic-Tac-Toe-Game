//
//  FiveToFiveExecutionState.swift
//  XO-game
//
//  Created by Alexander Andrianov on 29.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

final class FiveToFiveExecutionState: GameState {
  
  private enum Constants {
    static let executionTitle: String = "Setting marks"
  }
  
  private(set) var isCompleted = false
  
  private(set) weak var gameViewController: GameViewController?
  private(set) weak var gameboard: Gameboard?
  private(set) weak var gameboardView: GameboardView?
  
  init(gameViewController: GameViewController,
       gameboard: Gameboard,
       gameboardView: GameboardView) {
    
    self.gameViewController = gameViewController
    self.gameboard = gameboard
    self.gameboardView = gameboardView
  }
  
  func begin() {
    gameViewController?.winnerLabel.isHidden = false
    gameViewController?.firstPlayerTurnLabel.isHidden = true
    gameViewController?.secondPlayerTurnLabel.isHidden = true
    gameViewController?.winnerLabel.text = Constants.executionTitle
    gameViewController?.commandInvoker.executeCommands()
  }
  
  func addMark(at position: GameboardPosition) {
    guard
      let gameViewController = gameViewController,
      gameViewController.commandInvoker.allCommands.isEmpty
    else { return }
    isCompleted = true
  }
  
}

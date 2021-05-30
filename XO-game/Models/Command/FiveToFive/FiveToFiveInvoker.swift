//
//  FiveToFiveInvoker.swift
//  XO-game
//
//  Created by Alexander Andrianov on 29.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

final class FiveToFiveInvoker {
  
  private enum Constants {
    static let executionDelay: Double = 0.5
  }
  
  weak var gameboard: Gameboard?
  weak var gameboardView: GameboardView?
  
  var allCommands: [FiveToFiveCommand] = []
  
  init(gameboard: Gameboard, gameboardView: GameboardView) {
    self.gameboard = gameboard
    self.gameboardView = gameboardView
  }
  
  func addCommand(player: Player, position: GameboardPosition) {
    guard let gameboard = gameboard,
          let gameboardView = gameboardView
    else { return }
    
    let command = SetMarkCommand(player: player,
                                 position: position,
                                 gameboard: gameboard,
                                 gameboardView: gameboardView)
    allCommands.append(command)
  }
  
  func executeCommands() {
    sortCommands()
    
    var executionDelay: Double = Constants.executionDelay
    
    allCommands.forEach { _ in
      DispatchQueue.main.asyncAfter(deadline: .now() + executionDelay) {
        let command = self.allCommands.removeFirst()
        command.execute()
      }
      executionDelay += Constants.executionDelay
    }
  }
  
  private func sortCommands() {
    let firstPlayerCommands = allCommands.filter { $0.player == .first }
    allCommands = allCommands.filter { $0.player == .second }
    
    firstPlayerCommands
      .enumerated()
      .reversed()
      .forEach { allCommands.insert($1, at: $0) }
  }
}

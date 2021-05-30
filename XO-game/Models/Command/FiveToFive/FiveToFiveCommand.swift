//
//  FiveToFiveCommand.swift
//  XO-game
//
//  Created by Alexander Andrianov on 29.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

protocol FiveToFiveCommand {
  var player: Player { get }
  func execute()
}

final class SetMarkCommand: FiveToFiveCommand {
  
  var player: Player
  var position: GameboardPosition
  weak var gameboard: Gameboard?
  weak var gameboardView: GameboardView?
  
  init(player: Player,
       position: GameboardPosition,
       gameboard: Gameboard,
       gameboardView: GameboardView) {
    self.player = player
    self.position = position
    self.gameboard = gameboard
    self.gameboardView = gameboardView
  }
  
  func execute() {
    guard
      let gameboard = gameboard,
      let gameboardView = gameboardView
    else { return }
    
    if !gameboardView.canPlaceMarkView(at: position) {
      gameboardView.removeMarkView(at: position)
    }
    gameboard.setPlayer(player, at: position)
    gameboardView.placeMarkView(player.markViewPrototype, at: position)
    gameboardView.onSelectPosition!(position)
  }
  
}

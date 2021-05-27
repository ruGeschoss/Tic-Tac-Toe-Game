//
//  GameState.swift
//  XO-game
//
//  Created by Alexander Andrianov on 27.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

protocol GameState {
  var isCompleted: Bool { get }
  
  func begin()
  func addMark(at position: GameboardPosition)
}

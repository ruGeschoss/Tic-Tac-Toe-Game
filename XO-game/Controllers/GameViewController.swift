//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  
  @IBOutlet var gameboardView: GameboardView!
  @IBOutlet var firstPlayerTurnLabel: UILabel!
  @IBOutlet var secondPlayerTurnLabel: UILabel!
  @IBOutlet var winnerLabel: UILabel!
  @IBOutlet var restartButton: UIButton!
  
  var gameMode: GameStrategy?
  private lazy var referee = Referee(gameboard: gameboard)
  private let gameboard = Gameboard()
  private var currentState: GameState! {
    didSet {
      self.currentState.begin()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    goToFirstState()
    
    gameboardView.onSelectPosition = { [weak self] position in
      guard let self = self else { return }
      self.currentState.addMark(at: position)
      
      if self.currentState.isCompleted {
        self.goToNextState()
      }
    }
  }
  
  @IBAction func restartButtonTapped(_ sender: UIButton) {
    gameboardView.clear()
    gameboard.clear()
    log(.restartGame)
    goToFirstState()
  }
}

extension GameViewController {
  
  private func goToFirstState() {
    currentState = gameMode?.setFirstState(gameboard: gameboard,
                                           gameboardView: &gameboardView,
                                           gameViewController: self)
  }
  
  private func goToNextState() {
    let marksCount = gameboardView.markViewForPosition.count
    if marksCount == GameboardSize.maxFields
        || referee.determineWinner() != nil {
      
      let winner = referee.determineWinner()
      currentState = GameEndedState(winner: winner, gameViewController: self)
      return
    }
    
    gameMode?.setNextState(currentState: &currentState,
                           gameboard: gameboard,
                           gameboardView: &gameboardView,
                           gameViewController: self)
  }
}

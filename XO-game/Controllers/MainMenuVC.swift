//
//  MainMenuVC.swift
//  XO-game
//
//  Created by Alexander Andrianov on 28.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

final class MainMenuVC: UIViewController {
  
  private enum Constants {
    static let onePlayerTitle = "Player VS NPC"
    static let twoPlayersTitle = "Player VS Player"
    static let fiveToFiveTitle = "5 to 5"
  }
  
  @IBOutlet weak var onePlayer: UIButton!
  @IBOutlet weak var twoPlayers: UIButton!
  @IBOutlet weak var fiveToFive: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setButtonTitles()
  }
  
  private func startGameWithMode(gameMode: GameMode) {
    guard
      let destination = storyboard?
        .instantiateViewController(withIdentifier: GameViewController.storyboardID)
        as? GameViewController
    else { return }
    destination.gameMode = gameMode.strategy
    navigationController?.pushViewController(destination, animated: true)
  }
  
  @IBAction func onePlayerTapped(_ sender: UIButton) {
    startGameWithMode(gameMode: .playerVersusNPC)
  }
  
  @IBAction func twoPlayersTapped(_ sender: UIButton) {
    startGameWithMode(gameMode: .twoPlayers)
  }
  @IBAction func fiveToFiveTapped(_ sender: UIButton) {
    startGameWithMode(gameMode: .fiveToFive)
  }
}

// MARK: - Setup
extension MainMenuVC {
  private func setButtonTitles() {
    onePlayer.setTitle(Constants.onePlayerTitle, for: .normal)
    twoPlayers.setTitle(Constants.twoPlayersTitle, for: .normal)
    fiveToFive.setTitle(Constants.fiveToFiveTitle, for: .normal)
  }
}

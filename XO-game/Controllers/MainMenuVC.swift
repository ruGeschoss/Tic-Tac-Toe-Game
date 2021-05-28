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
  }
  
  @IBOutlet weak var onePlayer: UIButton!
  @IBOutlet weak var twoPlayers: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    onePlayer.setTitle(Constants.onePlayerTitle, for: .normal)
    twoPlayers.setTitle(Constants.twoPlayersTitle, for: .normal)
  }
  
  @IBAction func onePlayerTapped(_ sender: UIButton) {
    guard
      let destination = storyboard?
        .instantiateViewController(withIdentifier: GameViewController.storyboardID)
        as? GameViewController
    else { return }
    destination.gameMode = GameMode.playerVersusNPC.strategy
    navigationController?.pushViewController(destination, animated: true)
  }
  
  @IBAction func twoPlayersTapped(_ sender: UIButton) {
    guard
      let destination = storyboard?
        .instantiateViewController(withIdentifier: GameViewController.storyboardID)
        as? GameViewController
    else { return }
    destination.gameMode = GameMode.twoPlayers.strategy
    navigationController?.pushViewController(destination, animated: true)
  }
}

//
//  +UIViewController.swift
//  XO-game
//
//  Created by Alexander Andrianov on 28.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

extension UIViewController: AccessibleVC {}

protocol AccessibleVC {}

extension AccessibleVC where Self: UIViewController {
  static var storyboardID: String {
    String(describing: self)
  }
}

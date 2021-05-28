//
//  Copying.swift
//  XO-game
//
//  Created by Alexander Andrianov on 27.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

protocol Copying {
  
  init(_ prototype: Self)
  
}

extension Copying {

  func copy() -> Self {
    type(of: self).init(self)
  }
  
}

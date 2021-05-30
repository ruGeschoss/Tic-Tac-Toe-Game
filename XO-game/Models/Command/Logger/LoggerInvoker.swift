//
//  LoggerInvoker.swift
//  XO-game
//
//  Created by Alexander Andrianov on 27.05.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

final class LoggerInvoker {
  
  static let shared = LoggerInvoker()
  
  private let logger = Logger()
  private var commands: [LogCommand] = []
  private let batchSize = 10
  
  func addLogCommand(_ command: LogCommand) {
    commands.append(command)
    executeCommandsIfNeeded()
  }
  
  private func executeCommandsIfNeeded() {
    guard commands.count >= batchSize else { return }
    commands.forEach { logger.writeMessageToLog($0.logMessage) }
    commands.removeAll()
  }
}

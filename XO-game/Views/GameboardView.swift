//
//  GameBoardView.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

// MARK: - GameboardView
public class GameboardView: UIView {
    
    // MARK: - Public Properties
    
    public var onSelectPosition: ((GameboardPosition) -> Void)?
    
    public private(set) var markViewForPosition: [GameboardPosition: MarkView] = [:]
    
    // MARK: - Constants
    
    internal struct Constants {
        static let lineColor: UIColor = .black
        static let lineWidth: CGFloat = 7
    }
    
    // MARK: - Private Properties
    
    private var calculatedColumnWidth: CGFloat {
        return bounds.width / CGFloat(GameboardSize.columns)
    }
    private var calculatedRowHeight: CGFloat {
        return bounds.height / CGFloat(GameboardSize.rows)
    }
    
    // MARK: - Public
    
    public func clear() {
        for (_, markView) in markViewForPosition {
            markView.removeFromSuperview()
        }
        markViewForPosition = [:]
    }
    
    public func canPlaceMarkView(at position: GameboardPosition) -> Bool {
        return markViewForPosition[position] == nil
    }
    
    public func placeMarkView(_ markView: MarkView, at position: GameboardPosition) {
        guard self.canPlaceMarkView(at: position) else { return }
        updateFrame(for: markView, at: position)
        markViewForPosition[position] = markView
        addSubview(markView)
    }
    
    public func removeMarkView(at position: GameboardPosition) {
        guard let markView = markViewForPosition[position] else {
            return
        }
        markViewForPosition[position] = nil
        markView.removeFromSuperview()
    }
    
    // MARK: - UIView
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        Constants.lineColor.setStroke()
        drawColumnLines(for: rect)
        drawRowLines(for: rect)
    }
    
    // MARK: - Touch Handling
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self) else { return }
        let position = GameboardPosition(column: determineColumn(for: touchLocation),
                                         row: determineRow(for: touchLocation))
        onSelectPosition?(position)
    }
    
    // MARK: - UI
    
    private func drawColumnLines(for rect: CGRect) {
        let columnWidth = self.calculatedColumnWidth
        for column in 1 ..< GameboardSize.columns {
            let linePath = UIBezierPath()
            linePath.move(to: CGPoint(x: rect.minX + CGFloat(column) * columnWidth,
                                      y: rect.minY))
            linePath.addLine(to: CGPoint(x: rect.minX + CGFloat(column) * columnWidth,
                                         y: rect.minY + rect.height))
            linePath.lineWidth = Constants.lineWidth
            linePath.stroke()
        }
    }
    
    private func drawRowLines(for rect: CGRect) {
        let rowHeight = self.calculatedRowHeight
        for row in 1 ..< GameboardSize.rows {
            let linePath = UIBezierPath()
            linePath.move(to: CGPoint(x: rect.minX, y: rect.minY + CGFloat(row) * rowHeight))
            linePath.addLine(to: CGPoint(x: rect.minX + rect.width, y: rect.minY + CGFloat(row) * rowHeight))
            linePath.lineWidth = Constants.lineWidth
            linePath.stroke()
        }
    }
    
    // MARK: - Private
    
    private func determineColumn(for touchLocation: CGPoint) -> Int {
        let columnWidth = self.calculatedColumnWidth
        let lastColumn = GameboardSize.columns - 1
        for column in (0 ..< lastColumn) {
            let xMin = CGFloat(column) * columnWidth
            let xMax = CGFloat(column + 1) * columnWidth
            if (xMin ..< xMax).contains(touchLocation.x) {
                return column
            }
        }
        return lastColumn
    }
    
    private func determineRow(for touchLocation: CGPoint) -> Int {
        let rowHeight = self.calculatedRowHeight
        let lastRow = GameboardSize.rows - 1
        for row in (0 ..< lastRow) {
            let yMin = CGFloat(row) * rowHeight
            let yMax = CGFloat(row + 1) * rowHeight
            if (yMin ..< yMax).contains(touchLocation.y) {
                return row
            }
        }
        return lastRow
    }
    
    private func updateFrame(for markView: MarkView, at position: GameboardPosition) {
        let columnWidth = self.calculatedColumnWidth
        let rowHeight = self.calculatedRowHeight
        markView.frame = CGRect(x: CGFloat(position.column) * columnWidth,
                                y: CGFloat(position.row) * rowHeight,
                                width: columnWidth,
                                height: rowHeight).insetBy(dx: 0.5 * Constants.lineWidth,
                                                           dy: 0.5 * Constants.lineWidth)
    }
}

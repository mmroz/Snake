//
//  Model.swift
//  Snake
//
//  Created by Mark Mroz on 2016-09-09.
//  Copyright © 2016 MarkMroz. All rights reserved.
//

import Foundation

public protocol SnakeDelegate {
    func onGameStart()
    func onMoveExecuted()
    func onGameEnded()
}

enum MoveSnake {
    case Up
    case Down
    case Left
    case Right
}

class GameModel {
    
    // MARK: - Properties
    
    var stopped = true
    
    var snakePositions : [Position] = []
    var tokenPosition : Position
    
    // MARK: - Initialize
    
    init(initialLength : Int = 3, startingHeight : Int = 0) {
        for i in 0...initialLength {
            let newPosition = Position(x: i + (GameboardConstants.NumberOfTile  / 2) , y: startingHeight + (GameboardConstants.NumberOfTile / 2))
            snakePositions.append(newPosition)
        }
        
        let randomX = Int(arc4random_uniform(UInt32(GameboardConstants.NumberOfTile)))
        let randomY = Int(arc4random_uniform(UInt32(GameboardConstants.NumberOfTile)))
        
        tokenPosition = Position(x: randomX, y: randomY)
    }
    
    // MARK: - Delegate
    
    var delegate : SnakeDelegate!
    
    func setDelegateWith(delegator : SnakeDelegate) {
        self.delegate = delegator
    }
    
    // MARK: - Game functionality
    
    func startGame() {
        print("start From model")
        
        self.stopped = false
        
        
        if let delegate = self.delegate {
            delegate.onGameStart()
        }
    }
    
    var nextPosition : MoveSnake = .Left
    
    // MARK: - Game movement functions
    
    
    func moveSnake() {
        
        print("moving snake")
        
        switch nextPosition {
        case .Up:
            moveUp()
        case .Down:
            moveDown()
        case .Left:
            moveLeft()
        case .Right:
            moveRight()
        }
        
        if let delegate = self.delegate {
            delegate.onMoveExecuted()
        }
        
    }
    
    // Move Up
    
    func moveUp() {
        
        print("Moving Up")
        
        var tempPositions: [Position] = []
        
        for i in 0..<snakePositions.count {
            
            let x = snakePositions[i].getX()
            let y = snakePositions[i].getY()
            
            var updatedPosition = snakePositions[i]
            
            if i == 0 {
                updatedPosition = Position(x: x, y: (y - 1))
            } else {
                updatedPosition = snakePositions[i - 1]
            }
            
            tempPositions.append(updatedPosition)
            
            
        }
        
        snakePositions = tempPositions
        
    }
    
    // Move Left
    
    func moveLeft() {
        
        print("Moving Left")
        
        var tempPositions: [Position] = []
        
        for i in 0..<snakePositions.count {
            
            let x = snakePositions[i].getX()
            let y = snakePositions[i].getY()
            
            var updatedPosition = snakePositions[i]
            
            if i == 0 {
                updatedPosition = Position(x: (x - 1), y: y)
            } else {
                updatedPosition = snakePositions[i - 1]
            }
            
            tempPositions.append(updatedPosition)
            
        }
        
        snakePositions = tempPositions
        
    }
    
    // Move Right
    
    func moveRight() {
        
        print("Moving Right")
        
        var tempPositions: [Position] = []
        
        for i in 0..<snakePositions.count {
            
            let x = snakePositions[i].getX()
            let y = snakePositions[i].getY()
            
            var updatedPosition = snakePositions[i]
            
            if i == 0 {
                updatedPosition = Position(x: x + 1, y: y)
            } else {
                updatedPosition = snakePositions[i - 1]
            }
            
            tempPositions.append(updatedPosition)
            
        }
        
        snakePositions = tempPositions
        
    }
    
    // Move Down
    
    func moveDown() {
        
        
        print("Moving Down")
        
        var tempPositions: [Position] = []
        
        for i in 0..<snakePositions.count {
            
            let x = snakePositions[i].getX()
            let y = snakePositions[i].getY()
            
            var updatedPosition = snakePositions[i]
            
            if i == 0 {
                updatedPosition = Position(x: x, y: (y + 1))
            } else {
                updatedPosition = snakePositions[i - 1]
            }
            
            tempPositions.append(updatedPosition)
            
        }
        
        snakePositions = tempPositions
    }
    
    // MARK: - Check for loss
    
    func checkForLoss() -> Bool {
        
        let headPosition = snakePositions.first!
        
        if headPosition.getX() < 0 || headPosition.getX() > GameboardConstants.NumberOfTile - 1 {
            if let delegate = self.delegate {
                delegate.onGameEnded()
            }
            return true
        } else if headPosition.getY() < 0 || headPosition.getY() > GameboardConstants.NumberOfTile - 1 {
            if let delegate = self.delegate {
                delegate.onGameEnded()
            }
            return true
        }
        
        for i in 1..<snakePositions.count {
            if snakePositions[i] == headPosition {
                
                if let delegate = self.delegate {
                    delegate.onGameEnded()
                }
                return true
            }
        }
        return false
    }
    
    // MARK: - Update Token
    
    func updateToken() {
        
        for position in snakePositions {
            if position == tokenPosition {
                print("Token Hit")
                
                
                switch nextPosition {
                case .Up:
                    let x = snakePositions.last!.getX()
                    let y = snakePositions.last!.getY() - 1
                    
                    let newSnakeElement = Position(x: x, y: y)
                    
                    self.snakePositions.append(newSnakeElement)
                    
                case .Down:
                    let x = snakePositions.last!.getX()
                    let y = snakePositions.last!.getY() + 1
                    
                    let newSnakeElement = Position(x: x, y: y)
                    
                    self.snakePositions.append(newSnakeElement)
                    
                case .Left:
                    let x = snakePositions.last!.getX() - 1
                    let y = snakePositions.last!.getY()
                    
                    let newSnakeElement = Position(x: x , y: y)
                    
                    self.snakePositions.append(newSnakeElement)
                    
                case .Right:
                    let x = snakePositions.last!.getX() + 1
                    let y = snakePositions.last!.getY()
                    
                    let newSnakeElement = Position(x: x, y: y)
                    
                    self.snakePositions.append(newSnakeElement)
                }
                
                let randomX = Int(arc4random_uniform(UInt32(GameboardConstants.NumberOfTile)))
                let randomY = Int(arc4random_uniform(UInt32(GameboardConstants.NumberOfTile)))
                
                tokenPosition = Position(x: randomX, y: randomY)

                break
            }
        }
    }
}



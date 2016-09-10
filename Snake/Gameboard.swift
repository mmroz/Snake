//
//  Gameboard.swift
//  Snake
//
//  Created by Mark Mroz on 2016-09-09.
//  Copyright © 2016 MarkMroz. All rights reserved.
//

import UIKit

enum TileStates {
    case Empty
    case Snake
    case Token
}

class BoardTile : UIView {
    
    // MARK: - Properties
    
    private var position : Position!
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = GameboardConstants.TileBackgrounColour
        
        setBoarders()
    }
    
    func setBoarders(width : Int = 1 , colour : UIColor = UIColor.greenColor()) {
        self.layer.borderWidth = CGFloat(width)
        
        self.layer.borderColor = GameboardConstants.TileBoarderColour
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Tile states
    
    var state : TileStates = .Empty {
        didSet {
            switch state {
            case .Empty:
                self.setEmptyState()
            case .Snake :
                self.setSnakeState()
            case .Token :
                self.setTokenState()
            }
        }
    }
    
    func setState(state : TileStates) {
        self.state = state
    }
    
    func setEmptyState() {
        self.backgroundColor = GameboardConstants.EmptyTileColour
    }
    
    func setSnakeState() {
        self.backgroundColor = GameboardConstants.SnakeColour
    }
    
    func setTokenState() {
        self.backgroundColor = GameboardConstants.TokenTileColour
    }
    
    // Position getter and setter
    
    func setPosition(pos : Position) {
        self.position = pos
    }
    
    func getPosition() -> Position {
        return self.position
    }
}

class Gameboard: UIView {
    
    // MARK: - Properties
    
    var tiles : [BoardTile] = []
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initBoard(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // init board
    
    func initBoard(frame : CGRect) {
        
        let width = frame.width / CGFloat(GameboardConstants.NumberOfTile)
        let height = frame.height / CGFloat(GameboardConstants.NumberOfTile)
        
        for i in 0...(GameboardConstants.NumberOfTile - 1) {
            for j in 0...(GameboardConstants.NumberOfTile - 1) {
                let x = CGFloat(i) * width
                let y = CGFloat(j) * height
                
                let newTile = BoardTile(frame: CGRectMake(x,y,width,height))
                newTile.setPosition(Position(x: i, y: j))
                
                self.addSubview(newTile)
                
                tiles.append(newTile)
            }
        }
    }
    
    // MARK: - Update board
    
    func updateTiles(snakePositions : [Position] , tokenPosition : Position) {
        print("Updating positions in view with", snakePositions)
        
        for position in snakePositions {
            for tile in tiles {
                if position == tile.getPosition() {
                    tile.setState(.Snake)
                } else if tile.getPosition() == tokenPosition {
                    tile.setState(.Token)
                } else if !snakePositions.contains({ (pos) -> Bool in
                    return pos == tile.position
                }) {
                    tile.setState(.Empty)
                }
            }
        }
    }
}

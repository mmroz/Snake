//
//  Helpers.swift
//  Snake
//
//  Created by Mark Mroz on 2016-09-09.
//  Copyright © 2016 MarkMroz. All rights reserved.
//

import Foundation
import UIKit

struct Position {
    var x : Int
    var y : Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func getX() -> Int {
        return x
    }
    
    func getY() -> Int {
        return y
    }
    
    mutating func setX(x : Int) {
        self.x = x
    }
    
    mutating func setY(y : Int) {
        self.y = y
    }
    
}

func == (left: Position, right: Position) -> Bool {
    return left.getX() == right.getX() && left.getY() == right.getY()
}

func != (left: Position, right: Position) -> Bool {
    return left.getX() != right.getX() && left.getY() != right.getY()
}

struct GameboardConstants {
    static var BackgroundColour = UIColor.grayColor()
    
    static var TileBackgrounColour = UIColor.grayColor()
    static var SnakeColour = UIColor.greenColor()
    static var EmptyTileColour = UIColor.grayColor()
    static var TokenTileColour = UIColor.yellowColor()
    
    static var NumberOfTile = 30
    
    static var TileBoarderColourWidth = 1
    static var TileBoarderColour = UIColor.blackColor().CGColor
    
    
}

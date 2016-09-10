//
//  ViewController.swift
//  Snake
//
//  Created by Mark Mroz on 2016-09-09.
//  Copyright © 2016 MarkMroz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SnakeDelegate {
    
    // MARK: - Properties

    var gameboard : Gameboard!
    var game : GameModel!
    
    private var timer = NSTimer()
    private var timerSpeed = 0.3
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setPanGesture()
        
        readyGame()
        startGame()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Pan Gesture
    
    func setPanGesture() {
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panedView(_:)))
        self.view.addGestureRecognizer(panRecognizer)
    }
    
    var dx: CGFloat = 0
    var dy: CGFloat = 0
    
    
    func panedView(sender:UIPanGestureRecognizer){
       
        if (sender.state == UIGestureRecognizerState.Began) {
             print(sender.locationInView(self.view))
            dx = sender.locationInView(self.view).x
            dy = sender.locationInView(self.view).y
        } else if sender.state == UIGestureRecognizerState.Ended {
            dx -= sender.locationInView(self.view).x
            dy -= sender.locationInView(self.view).y
            
            if (abs(dx) > abs(dy)) {
                if (dx > 0) {
                    if game.nextPosition != .Right {
                        game.nextPosition = MoveSnake.Left
                    }
                } else {
                    if game.nextPosition != .Left {
                        game.nextPosition = MoveSnake.Right
                    }
                }
            } else if (abs(dx) < abs(dy)) {
                if (dy > 0) {
                    if game.nextPosition != .Down {
                        game.nextPosition = MoveSnake.Up
                    }
                } else {
                    if game.nextPosition != .Up {
                        game.nextPosition = MoveSnake.Down
                    }
                }
            }
        }
    }
    
    // MARK: - Initialize Game
    
    private func readyGame() {
        gameboard = Gameboard(frame: view.frame)
        self.view.addSubview(gameboard)
        
        game = GameModel()
        game.setDelegateWith(self)
    }
    
    private func startGame() {
        game.startGame()
    }
    
    // MARK: - Snake Delegate
    
    func onGameStart() {
        gameboard.updateTiles(game.snakePositions , tokenPosition: game.tokenPosition)
        
        print("Game started in VC")
        
        startTimer()
    }
    
    func onMoveExecuted() {
        print("Move Made on board")
        
        print("Checking Losing")
        
        if (!game.checkForLoss()) {
        
            print("Checking Token Tile")
        
            game.updateToken()
        
            gameboard.updateTiles(game.snakePositions, tokenPosition: game.tokenPosition)
            print("Updated Gameboard")
        }
        
    }
    
    func onGameEnded() {
        print("Game Ended")
        
        timer.invalidate()
        
        let alert = UIAlertController(title: "Game Over", message: "Run Again?", preferredStyle: .ActionSheet)
        
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            print("Ok Button Pressed")
            self.readyGame()
            self.startGame()
        })
        
        alert.addAction(ok)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - Game Timer
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(timerSpeed, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func timerAction() {
        print("Timer Hit")
        
        game.moveSnake()
        
    }


}


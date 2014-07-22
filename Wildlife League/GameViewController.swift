//
//  GameViewController.swift
//  Wildlife League
//
//  Created by allenlin on 7/8/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    var scene: GameScene!
    var board: Board!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as SKView
        skView.multipleTouchEnabled = false
        
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = SKSceneScaleMode.AspectFill

        self.board = Board()
        scene.board = board
        
        skView.presentScene(scene)
        
        startGame()
    }

    override func shouldAutorotate() -> Bool {
        return false
    }

    func startGame() {
        scene.addSpritesForBoard(board)
    }
    
}

//
//  GameScene+DropSprites.swift
//  Wildlife League
//
//  Created by allenlin on 7/21/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

import SpriteKit

extension GameScene {
    func doDropBeeds () {
        board.fillBeeds()
        fillBeedsSprite()
        dropBeedsSprite()
        
        self._delay({
            self.doErase()
            }, delayInSeconds: 0.7)
    }
    
    func fillBeedsSprite () {
        for col in 0..<NumColumns {
            var newBeedRow = -1
            for (var row = NumRows-1 ; row>=0 ; row--){
                
                if let spriteL = board[col,row]?.sprite {
                    
                }
                else {
                    var newBeed = board[col,row]!
                    
                    let sprite = self.roundSpriteBeedNode(newBeed.beedType.spriteColor, size: CGSizeMake(TileWidth, TileHeight))
                    sprite.position = pointAtColumn(col, row: newBeedRow)
                    newBeedRow--
                    sprite.setScale(0.8)
                    beedLayer.addChild(sprite)
                    newBeed.sprite = sprite
                }
            }
        }
    }
    
    func dropBeedsSprite () {
        for col in 0..<NumColumns {
            for (var row = NumRows-1 ; row>=0 ; row--){
                var beed = board[col,row]!
                var fallingSprite = beed.sprite!
                let fall = SKAction.moveTo(self.pointAtColumn(beed.column, row: beed.row), duration: 0.2)
                fall.timingMode = .EaseIn
                fallingSprite.runAction(fall)
            }
        }
    }
}
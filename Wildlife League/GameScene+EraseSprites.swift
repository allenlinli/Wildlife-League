//
//  GameScene+EraseSprites.swift
//  Wildlife League
//
//  Created by allenlin on 7/21/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

import SpriteKit

extension GameScene {
    func eraseEmptyBeedsSprites () {
        for col in 0..<NumColumns {
            for (var row = NumRows-1 ; row>=0 ; row--){
                var beed = board[col,row]!
                if(beed.beedType == BeedType.BeedTypeEmpty){
                    beed.sprite?.runAction((SKAction.sequence([SKAction.fadeOutWithDuration(0.05),SKAction.removeFromParent()])))
                }
            }
        }
    }
    
    func doErase () {
        board.findMergedChains()
        if (board.chains.count()==0){
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            return
        }
        board.eraseChains()
        eraseEmptyBeedsSprites()
        
        self._delay({
            self.doDropBeeds()
            }, delayInSeconds: 0.7)
    }
}
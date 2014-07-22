//
//  GameScene+Touches.swift
//  Wildlife League
//
//  Created by allenlin on 7/21/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

import SpriteKit

extension GameScene {
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        assert(!(beedMoving || beedToMove || beedSwapped),"error")
        
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(beedLayer)
        
        let (success, column, row) = convertPointToBoardCoordinate(location)
        if success {
            if let beed = board[column, row] {
                self.beedToMove = beed
                beed.sprite!.alpha = 0.5
                self.addCopyBeedOnBoard(beedToCopy: beed, location: location)
            }
        }
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(beedLayer)
        if let beedMoving = beedMoving {
            if let sprite = beedMoving.sprite {
                sprite.position = location
            }
        }
        
        let (success, column, row) = convertPointToBoardCoordinate(location)
        
        if success {
            if(column==self.beedMoving!.column && row==self.beedMoving!.row){
                return
            }
            self.beedMoving!.column = column
            self.beedMoving!.row = row
            beedSwapped = board[column, row]
            self.swapTwoBeeds(beed1: self.beedToMove!, beed2: self.beedSwapped!)
            board.insertBeed(self.beedToMove!)
            board.insertBeed(self.beedSwapped!)
        }
        else{
            beedMoving?.sprite!.runAction(SKAction.sequence([
                SKAction.fadeOutWithDuration(0),
                SKAction.removeFromParent(),
                SKAction.runBlock({
                    ()->() in
                    self.beedMoving!.sprite!.removeFromParent()
                    self.beedMoving = nil
                    self.beedToMove!.sprite!.alpha = 1
                    self.beedSwapped = nil
                    self.beedToMove = nil
                    })]
                ))
        }
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        beedMoving!.sprite!.removeFromParent()
        beedMoving = nil
        beedToMove!.sprite!.alpha = 1
        beedSwapped = nil
        beedToMove = nil
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        beedMoving?.sprite!.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0),SKAction.removeFromParent()]))
        if let bm = beedToMove {
            bm.sprite!.alpha = 1
            
            self.doErase()

        }
        beedMoving = nil
        beedSwapped = nil
        beedToMove = nil
    }
    
    func swapTwoBeeds(#beed1 :Beed, beed2 :Beed) {
        var tempRow = beed1.row
        var tempColumn = beed1.column
        
        beed1.row = beed2.row
        beed1.column = beed2.column
        
        beed2.row = tempRow
        beed2.column = tempColumn
        
        let Duration: NSTimeInterval = 0.05
        
        let moveA = SKAction.moveTo(self.pointAtColumn(beed1.column, row: beed1.row), duration: Duration)
        moveA.timingMode = .Linear
        
        if let existingAction = beed1.sprite!.actionForKey("move") {
            let newAction = SKAction.sequence([existingAction, moveA])
            beed1.sprite!.removeAllActions()
            beed1.sprite!.runAction(newAction, withKey: "move")
            
        } else {
            beed1.sprite!.runAction(moveA, withKey: "move")
        }
        
        let moveB = SKAction.moveTo(self.pointAtColumn(beed2.column, row: beed2.row), duration: Duration)
        moveB.timingMode = .EaseOut
        beed2.sprite!.runAction(moveB)
    }
}
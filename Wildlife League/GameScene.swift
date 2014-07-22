//
//  GameScene.swift
//  Wildlife League
//
//  Created by allenlin on 7/8/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    let beedLayer = SKNode()
    
    let TileWidth: CGFloat = 320.0/6.0
    let TileHeight: CGFloat = 568.0/2.0/5.0
    
    var board: Board!
    
    var beedToMove :Beed?
    var beedMoving :Beed?
    var beedSwapped :Beed?
    
    init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let background = SKSpriteNode(color: UIColor(red: 0.8, green: 1, blue: 1, alpha: 1), size: CGSizeMake(320, 568))
        
        var point = background.position
        background.position = point
        addChild(background)
        
        let layerPosition = CGPoint(
            x: -TileWidth * CGFloat(NumColumns) / 2,
            y: -TileHeight*2 * CGFloat(NumRows) / 2)
        
        beedLayer.position = layerPosition
        let backgroundLayer = SKSpriteNode(color: UIColor.grayColor(), size: CGSizeMake(320, 568/2))
        point = backgroundLayer.position
        point.y = -568/2/2
        backgroundLayer.position = point
        
        var mask = SKSpriteNode(color: UIColor.grayColor(), size: CGSizeMake(320, 568/2))
        mask.position = point
        var cropNode = SKCropNode();
        cropNode.addChild(beedLayer)
        cropNode.maskNode = mask
        background.addChild(backgroundLayer)
        background.addChild(cropNode)
    }
    
    func roundSpriteBeedNode (color :UIColor, size :CGSize)-> SKNode{
        var mask = SKShapeNode(path: CGPathCreateWithRoundedRect(CGRectMake(0, 0, TileWidth, TileHeight), 8.0, 8.0, nil))
        var sprite = SKSpriteNode(color: color, size: size)
        var cropNode = SKCropNode()
        cropNode.addChild(sprite)
        cropNode.maskNode = mask
        return sprite
    }
    
    func addSpritesForBoard(board :Board) {
        for beed in board.grid {
            if let realBeed = beed{
                if (realBeed.beedType==BeedType.BeedTypeEmpty) {
                    continue
                }
                let sprite = self.roundSpriteBeedNode(realBeed.beedType.spriteColor, size: CGSizeMake(TileWidth, TileHeight))
                sprite.position = pointAtColumn(realBeed.column, row: realBeed.row)
                sprite.setScale(0.8)
                
                beedLayer.addChild(sprite)
                
                realBeed.sprite = sprite
            }
        }
    }
    
    func addCopyBeedOnBoard(#beedToCopy :Beed, location :CGPoint) {
        beedMoving = beedToCopy.copy()
        beedMoving!.sprite!.alpha = 0.7
        beedMoving!.sprite!.position = location
        beedLayer.addChild(beedMoving!.sprite)
    }
    
    func _delay(block :()->(), delayInSeconds :NSTimeInterval) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
        dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            block()
        })
    }
}

extension GameScene {
    func convertPointToBoardCoordinate(point :CGPoint) -> (Bool, Int, Int) {
        if (point.x >= 0 && point.x < CGFloat(NumColumns)*self.TileWidth &&
            point.y >= 0 && point.y < CGFloat(NumRows)*self.TileHeight) {
                return (true, Int(point.x/TileWidth), NumRows - Int(point.y/TileHeight) - 1)
        }
        else {
            return (false, 0, 0)
        }
    }
    
    func pointAtColumn(column: Int, row: Int) -> CGPoint {
        return CGPoint (x: CGFloat(column)*TileWidth + TileWidth/2, y: CGFloat(NumRows-1) * TileHeight - CGFloat(row)*TileHeight + TileHeight/2)
    }
}

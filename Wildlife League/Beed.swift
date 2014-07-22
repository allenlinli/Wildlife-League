//
//  Beed.swift
//  Wildlife League
//
//  Created by allenlin on 7/8/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

import Foundation
import SpriteKit


enum BeedType : Int {
    case BeedTypeEmpty, BeedTypeBlue, BeedTypeRed, BeedTypeGreen, BeedTypeYellow, BeedTypePurple, BeedTypeOrange
    
    static func randomType() -> BeedType{
        return BeedType.fromRaw(Int(arc4random_uniform(6))+1)!
    }
    
    var spriteName: String {
        let spriteNames = [
            "",
            "Prionailurus bengalensis",
            "Pholidota",
            "Paguma larvata",
            "Ursus thibetanus formosanus",
            "Cervus nippon taiouanus",
            "Neofelis nebulosa brachyura"]
            
            return spriteNames[toRaw()]
    }
    
    var spriteColor: UIColor {
        let spriteColors = [
            UIColor.whiteColor(),
            UIColor.blueColor(),
            UIColor.redColor(),
            UIColor.greenColor(),
            UIColor.yellowColor(),
            UIColor.purpleColor(),
            UIColor.orangeColor()
        ]
            
        return spriteColors[toRaw()]
    }
}

class Beed: Hashable, Printable {
    var beedType : BeedType
    var column : Int
    var row : Int
    var sprite: SKNode?
    
    enum BeedTouchType {
        case BeedTouchTypeNormal,
        BeedTouchTypeTouchBegan,
        BeedTouchTypeTouchMoving
    }
    
    var inBeedTouchType :BeedTouchType
    
    var beedTouchType :BeedTouchType{
        get{
            return inBeedTouchType
        }
        set(parameter){
            switch parameter {
            case .BeedTouchTypeNormal:
                self.sprite!.alpha = 1
            case .BeedTouchTypeTouchBegan:
                self.sprite!.alpha = 0.4
            case .BeedTouchTypeTouchMoving:
                self.sprite!.alpha = 0.7
            }
            
            inBeedTouchType = parameter
        }
    }
    
    init(column: Int, row:Int, beedType:BeedType) {
        self.beedType = beedType
        self.column = column
        self.row = row
        self.inBeedTouchType = BeedTouchType.BeedTouchTypeNormal
    }
    
    var hashValue : Int {
        return row*6 + column 
    }
    
    var description :String {
        return "(\(row)/\(column)/\(beedType.toRaw()))"
    }
    
    func copy() -> Beed {
        var beedCopy = Beed(column: self.column, row: self.row, beedType: self.beedType)
        if let sprite = self.sprite {
            beedCopy.sprite = sprite.copy() as? SKSpriteNode
        }
        return beedCopy
    }
}



func ==(lhs: Beed, rhs: Beed) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row
}
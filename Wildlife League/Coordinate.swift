//
//  Coordinate.swift
//  Wildlife League
//
//  Created by allenlin on 7/17/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

import Foundation

struct Coordinate : Hashable, Equatable, Printable{
    var x :Int
    var y :Int
    
    init(x :Int, y :Int){
        self.x = x
        self.y = y
    }
    
    init(beed: Beed) {
        self.init(x: beed.column, y: beed.row)
    }
    
    var hashValue: Int {
        get{
            return y * NumColumns + x
        }
    }
    
    var description :String {
        get{
            return "\(x,y)"
        }
    }
}

func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

extension Coordinate{
    
    static func turnChainToCoordinateSet (chain :Chain) -> Set<Coordinate> {
        var coorSet = Set<Coordinate>()
        
        for beed in chain {
            coorSet.addElement(Coordinate(beed: beed))
        }
        
        return coorSet
    }
}
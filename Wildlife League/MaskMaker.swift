//
//  MaskMaker.swift
//  Wildlife League
//
//  Created by allenlin on 7/17/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

import Foundation

class MaskMaker {
    class func beedCrossMask(beed :Beed) -> Set<Coordinate>{
        var coor = Coordinate(beed: beed)
        return self.coordinateCrossMaskAtCoordinate(coor)
    }
    
    class func coordinateCrossMaskAtCoordinate (coor :Coordinate) -> Set<Coordinate>{
        var maskDiffTupleSet = [(0,1),(0,-1),(1,0),(-1,0),(0,0)]
        var maskSet = Set<Coordinate>()
        
        for tuple in maskDiffTupleSet {
            var (inDiffX, inDiffY) = tuple
            var tempCoor = Coordinate(x: coor.x + inDiffX, y: coor.y + inDiffY)
            if (tempCoor.x>=0 && tempCoor.x < NumColumns && tempCoor.y >= 0 && tempCoor.y < NumRows){
                maskSet.addElement(tempCoor)
            }
        }
        
        return maskSet
    }
    
    class func crossMaskSetOfCoordinateSet (set :Set<Coordinate>) -> Set<Coordinate> {
        var maskSet = Set<Coordinate>()
        for coor in set {
            maskSet.union(self.coordinateCrossMaskAtCoordinate(coor))
        }
        
        return maskSet
    }
    
    class func crossMaskSetOfChain (chain :Chain) -> Set<Coordinate> {
        return self.crossMaskSetOfCoordinateSet(Coordinate.turnChainToCoordinateSet(chain))
    }
}
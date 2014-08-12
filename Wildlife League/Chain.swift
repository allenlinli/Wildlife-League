//
//  Chain.swift
//  Wildlife League
//
//  Created by allenlin on 7/10/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

import Foundation

class Chain: Hashable, Printable, SequenceType {
    var beeds : Set<Beed>
    
    var length :Int {
        get {
            return beeds.allElements().count
        }
    }

    var chainType : BeedType {
        return beeds.allElements()[0].beedType
    }
    
    
    init(){
        beeds = Set<Beed>()
    }
    
    init(grid:Array2D<Beed>){
        beeds = Set<Beed>()
        
        for beed in grid {
            beeds.addElement(beed!)
        }
    }
    
    init(beeds :Set<Beed>){
        self.beeds = beeds
    }
    
    enum ChainDirection :Int{
        case ChainDirectionHorizontalNone,ChainDirectionHorizontal, ChainDirectionVertical
    }
    
    var chainDirection :ChainDirection{
        get{
            if (beeds[0]?.column == beeds[1]?.column) {
                return ChainDirection.ChainDirectionVertical
            }
            else if(beeds[0]?.row == beeds[1]?.row){
                return ChainDirection.ChainDirectionHorizontal
            }
            else {
                return ChainDirection.ChainDirectionHorizontalNone
            }
        }
    }
    
    func addBeed(beed :Beed) {
        beeds.addElement(beed)
    }
    
    var hashValue: Int {
        var hashValueSum = 0
        for beed in beeds{
            hashValueSum = hashValueSum ^ Int(pow(2, Double(beed.hashValue)))
        }
        return hashValueSum
    }
    
    func mergeChain(chain: Chain) {
        beeds.union(chain.beeds)
    }
    
    var description :String{
        var headBeed :Beed
        var tailBeed :Beed
        
        return "[chain : p1:\(beeds[0]) p2:\(beeds[2])  p3:\(beeds[1]) type:\(chainType.toRaw())]"
    }
    
    func generate() -> IndexingGenerator<Array<Beed>> {
        return beeds.allElements().generate()
    }
    
    func isConnectedToChain(chain :Chain) -> Bool{
        if (chain.length==0 || self.length==0){
            return false
        }
        
        var maskSet1 = MaskMaker.crossMaskSetOfChain(chain)
        var maskSet2 = MaskMaker.crossMaskSetOfChain(self)
        
        return maskSet1.isIntersected(maskSet2)
    }
}

func ==(lhs: Chain, rhs: Chain) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
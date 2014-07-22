//
//  Board+ChainsFinder.swift
//  Wildlife League
//
//  Created by allenlin on 7/17/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

import Foundation

extension Board {
    func findMergedChains() {
        for c in 0 ..< NumColumns {
            for r in 0 ..< NumRows {
                _addPossibleChainsInRightAndDownDirectionAt(column: c, row: r)
            }
        }
        
        self._mergeChains()
    }
    
    func _mergeChains() {
        var unprocessedChains = chains
        var processedChains = Set<Chain>()
        
        while (unprocessedChains.count() != 0){
        
            (unprocessedChains, processedChains) = Board._mergeChain(unprocessedChains :unprocessedChains, processedChains :processedChains)
        }
        
        chains = processedChains
    }
    
    class func _mergeChain (#unprocessedChains :Set<Chain>, processedChains :Set<Chain>) -> (Set<Chain>, Set<Chain>) {
        if (unprocessedChains.count()==0){
            return (unprocessedChains,processedChains)
        }
        
        var chain1 = unprocessedChains[0]!
        unprocessedChains.removeElement(chain1)
        for chain2 in unprocessedChains{
            if((chain1.chainType==chain2.chainType) && chain1.isConnectedToChain(chain2)){
                unprocessedChains.removeElement(chain2)
                chain1.mergeChain(chain2)
                unprocessedChains.addElement(chain1)

                return (unprocessedChains, processedChains)
            }
        }
        processedChains.addElement(chain1)
        return (unprocessedChains, processedChains)
    }
    
    
    func _addPossibleChainsInRightAndDownDirectionAt(#column :Int, row :Int) -> (Chain?,Chain?) {
        
        var mainBeedType = self[column, row]?.beedType
        
        if (column < 0 || column > NumColumns - 1 ) {
            return (nil,nil)
        }
        if (row < 0 || row > NumRows-1 ) {
            return (nil,nil)
        }
        
        //Horizontal
        var chainInHorizontal :Chain?
        chainInHorizontal = Chain()
        for i in 0..<3{
            if let beedAt = self[column+i, row] {
                if(beedAt.beedType != mainBeedType){
                    chainInHorizontal = nil
                    break
                }
                else{
                    chainInHorizontal!.addBeed(beedAt)
                }
            }
            else{
                chainInHorizontal = nil
            }
        }
        
        //Vertical
        var chainInVertical :Chain?
        chainInVertical = Chain()
        for i in 0..<3 {
            if let beedAt = self[column, row+i] {
                if(beedAt.beedType != mainBeedType){
                    chainInVertical = nil
                    break
                }
                else{
                    chainInVertical!.addBeed(beedAt)
                }
            }
            else{
                chainInVertical = nil
            }
        }
        
        if let chainH = chainInHorizontal {
            if (chainH.length) == 3 {
                chains.addElement(chainH)
            }
        }
        
        if let chainV = chainInVertical {
            if (chainV.length) == 3 {
                chains.addElement(chainV)
            }
        }
        
        return (chainInHorizontal,chainInVertical)
    }
}
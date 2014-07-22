//
//  Board.swift
//  Wildlife League
//
//  Created by allenlin on 7/9/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

import Foundation


let NumColumns = 6
let NumRows = 5

class Board {
    var grid :Array2D<Beed>
    var chains = Set<Chain>()
    
    init(){
        self.grid = Array2D<Beed>(columns: NumColumns, rows: NumRows)
        
        do{
            chains = Set<Chain>()
            for row in 0..<NumRows{
                for column in 0..<NumColumns{
                    grid[column, row] = Beed(column: column, row: row, beedType:BeedType.randomType())
                }
            }
            
            self.findMergedChains()
        }
        while (chains.count()>0)
    }
    
    subscript (column:Int, row:Int) -> Beed? {
        get{
            if(column<0 || column>NumColumns-1 || row<0 || row>NumRows-1) {
                return nil
            }
            return grid[column , row]
        }
        
        set (newValue) {
            if let beed = newValue as Beed?{
                grid[beed.column,beed.row] = beed
            }
        }
    }
    
    func insertBeed (beed:Beed) {
        self[beed.column,beed.row] = beed
    }
    
    func printBoard () {
        for r in 0..<NumRows{
            for c in 0..<NumColumns{
                print("\(self.grid[c,r]?.beedType.toRaw())  ")
            }
            println("")
        }
        
        println("----------------")   
    }
    
    func copy() -> Board {
        var boardCopy = Board()
        boardCopy.grid = self.grid
        boardCopy.chains = self.chains
        
        return boardCopy
    }
    
    func eraseChains () {
        for chain in chains{
            for beed in chain {
                beed.beedType = BeedType.BeedTypeEmpty
                self.insertBeed(beed)
            }
        }
        self.chains = Set<Chain>()
    }
}
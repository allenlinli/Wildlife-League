//
//  Board+BeedDropper.swift
//  Wildlife League
//
//  Created by allenlin on 7/21/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

import Foundation

extension Board {
    func fillBeeds() {
        var baseRow :Int
        for emptyCol in 0..<NumColumns {
            for (var emptyRow = NumRows-1; emptyRow>=0 ; emptyRow--){
                var emptyBeed = self[emptyCol,emptyRow]!
                if (emptyBeed.beedType == BeedType.BeedTypeEmpty){
                    baseRow = emptyRow+1
                    if let beedToFill = self._theBeedToFillOnTopAt(col: emptyCol,row: emptyRow) {
                        var oldRowOfBeedToFill = beedToFill.row
                        var oldColumnOfBeedToFill = beedToFill.column
                        beedToFill.row = emptyRow
                        beedToFill.column = emptyCol
                        self.insertBeed(beedToFill)
                        self.insertBeed(Beed(column: oldColumnOfBeedToFill, row: oldRowOfBeedToFill, beedType: BeedType.BeedTypeEmpty))
                    }
                    else {
                        /* Add New Beed Upon */
                        var newBeed = Beed(column: emptyCol, row: emptyRow, beedType: BeedType.randomType())
                        self.insertBeed(newBeed)
                    }
                }
            }
        }
    }
    
    func _theBeedToFillOnTopAt(#col :Int , row :Int) -> Beed?{
        for (var row2 = row-1; row2>=0 ; row2--){
            if self[col,row2]!.beedType != BeedType.BeedTypeEmpty {
                return self[col,row2]!
            }
        }
        
        return nil
    }
}
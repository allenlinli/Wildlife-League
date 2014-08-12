//
//  Array2D.swift
//  Wildlife League
//
//  Created by allenlin on 7/8/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

import Foundation


struct Array2D<T> :SequenceType{
    var array : Array<T?>
    let columns : Int
    let rows : Int
    
    init(columns :Int, rows :Int){
        self.columns = columns
        self.rows = rows
        array = Array<T?>(count:rows*columns, repeatedValue:nil)
    }
    
    init(columns :Int, rows :Int, repeatedValue: T){
        self.columns = columns
        self.rows = rows
        array = Array<T?>(count:rows*columns, repeatedValue:repeatedValue)
    }
    
    subscript (column:Int, row:Int) -> T? {
        get{
            return array[row*columns+column]
        }
        
        set (newValue) {
            array[row*columns+column] = newValue as T?
        }
    }
    
    func generate () -> IndexingGenerator<Array<T?>> {
        return array.generate()
    }
}
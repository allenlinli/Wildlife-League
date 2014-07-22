//
//  Wildlife_LeagueTests.swift
//  Wildlife LeagueTests
//
//  Created by allenlin on 7/8/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

import XCTest
import Wildlife_League

class Wildlife_LeagueTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSet(){
        var set = Set<String>()
        set.addElement("a")
        set.addElement("a")
        set.addElement("b")
        
        XCTAssertTrue(set.containsObject("a"), "Pass")
        XCTAssertTrue(set.containsObject("b"), "Pass")
        XCTAssertEqual(set.allElements().count, 2, "Pass")
        
        
        var beeds1 = Set<Beed>()
        beeds1.addElement(Beed(column: 1, row: 1, beedType: BeedType.BeedTypeRed))
        beeds1.addElement(Beed(column: 2, row: 1, beedType: BeedType.BeedTypeRed))
        
        var beeds2 = Set<Beed>()
        beeds2.addElement(Beed(column: 1, row: 1, beedType: BeedType.BeedTypeRed))
        beeds2.addElement(Beed(column: 0, row: 1, beedType: BeedType.BeedTypeRed))
        
        var beeds3 = Set<Beed>()
        beeds2.addElement(Beed(column: 0, row: 0, beedType: BeedType.BeedTypeRed))
        
        var beeds1Copy = beeds1.copy()
        for beed in beeds1 {
            XCTAssertTrue(beeds1Copy.containsObject(beed),"")
        }
        
        XCTAssertTrue(beeds1.isIntersected(beeds1), "")
        XCTAssertTrue(beeds1.isIntersected(beeds2), "")
        XCTAssertFalse(beeds1.isIntersected(beeds3), "")
        
        beeds1.intersect(beeds2)
        XCTAssertTrue(beeds1.containsObject(Beed(column: 1, row: 1, beedType: BeedType.BeedTypeRed)), "")
    }
    
    func testBeed(){
        var beed = Beed(column: 1, row: 2, beedType: BeedType.BeedTypeBlue)
        
        XCTAssertEqual(beed.column, 1, "Pass")
        XCTAssertEqual(beed.row, 2, "Pass")
        XCTAssertEqual(beed.beedType, BeedType.BeedTypeBlue, "Pass")
        
        var beed2 = Beed(column: 1, row: 2, beedType: BeedType.randomType())
        XCTAssertTrue(beed==beed2, "Pass")
    }

    func testBoard(){
        let columns = 6
        let rows = 5
        
        var board = Board()
        
        XCTAssertTrue(board.grid.columns == columns && board.grid.rows == rows, "Pass")

        for r in 0..<rows{
            for c in 0..<columns{
                print("\(board.grid[c, r]!.beedType.toRaw())  ")
            }
            println("")
        }

        board = Board()
    }
    

    func testMaskMaker() {
        var coorSet = MaskMaker.beedCrossMask(Beed(column: 0, row: 0, beedType: BeedType.BeedTypeRed))
        XCTAssert(coorSet.containsObject(Coordinate(x: 0, y: 0)), ".containsObject(Coordinate(x: 0, y: 0)")
        XCTAssert(coorSet.containsObject(Coordinate(x: 1, y: 0)), ".containsObject(Coordinate(x: 1, y: 0)")
        XCTAssert(coorSet.containsObject(Coordinate(x: 0, y: 1)), ".containsObject(Coordinate(x: 0, y: 1)")
        
        var coorSet2 = MaskMaker.beedCrossMask(Beed(column: 1, row: 1, beedType: BeedType.BeedTypeRed))
        XCTAssert(coorSet2.containsObject(Coordinate(x: 1, y: 1)), ".containsObject(Coordinate(x: 1, y: 1)")
        XCTAssert(coorSet2.containsObject(Coordinate(x: 1, y: 0)), ".containsObject(Coordinate(x: 1, y: 0)")
        XCTAssert(coorSet2.containsObject(Coordinate(x: 0, y: 1)), ".containsObject(Coordinate(x: 0, y: 1)")
        XCTAssert(coorSet2.containsObject(Coordinate(x: 1, y: 2)), ".containsObject(Coordinate(x: 1, y: 2)")
        XCTAssert(coorSet2.containsObject(Coordinate(x: 2, y: 1)), ".containsObject(Coordinate(x: 2, y: 1)")
        
        var coorSet3 = MaskMaker.coordinateCrossMaskAtCoordinate(Coordinate(x: 1, y: 1))
        XCTAssert(coorSet3.containsObject(Coordinate(x: 1, y: 1)), ".containsObject(Coordinate(x: 1, y: 1)")
        XCTAssert(coorSet3.containsObject(Coordinate(x: 1, y: 0)), ".containsObject(Coordinate(x: 1, y: 0)")
        XCTAssert(coorSet3.containsObject(Coordinate(x: 0, y: 1)), ".containsObject(Coordinate(x: 0, y: 1)")
        XCTAssert(coorSet3.containsObject(Coordinate(x: 1, y: 2)), ".containsObject(Coordinate(x: 1, y: 2)")
        XCTAssert(coorSet3.containsObject(Coordinate(x: 2, y: 1)), ".containsObject(Coordinate(x: 2, y: 1)")
        
        var set = Set<Beed>()
        set.addElement(Beed(column: 1, row: 1, beedType: BeedType.BeedTypeRed))
        set.addElement(Beed(column: 1, row: 2, beedType: BeedType.BeedTypeRed))
        var coorSet4 = MaskMaker.crossMaskSetOfCoordinateSet(Coordinate.turnChainToCoordinateSet(Chain(beeds: set)))
        XCTAssert(coorSet4.containsObject(Coordinate(x: 1, y: 1)), ".containsObject(Coordinate(x: 1, y: 1)")
        XCTAssert(coorSet4.containsObject(Coordinate(x: 1, y: 0)), ".containsObject(Coordinate(x: 1, y: 0)")
        XCTAssert(coorSet4.containsObject(Coordinate(x: 0, y: 1)), ".containsObject(Coordinate(x: 0, y: 1)")
        XCTAssert(coorSet4.containsObject(Coordinate(x: 1, y: 2)), ".containsObject(Coordinate(x: 1, y: 2)")
        XCTAssert(coorSet4.containsObject(Coordinate(x: 2, y: 1)), ".containsObject(Coordinate(x: 2, y: 1)")
        XCTAssert(coorSet4.containsObject(Coordinate(x: 2, y: 2)), ".containsObject(Coordinate(x: 1, y: 1)")
        XCTAssert(coorSet4.containsObject(Coordinate(x: 0, y: 2)), ".containsObject(Coordinate(x: 1, y: 0)")
        XCTAssert(coorSet4.containsObject(Coordinate(x: 1, y: 3)), ".containsObject(Coordinate(x: 0, y: 1)")
        
        
        var set5 = Set<Beed>()
        set5.addElement(Beed(column: 1, row: 1, beedType: BeedType.BeedTypeRed))
        set5.addElement(Beed(column: 1, row: 2, beedType: BeedType.BeedTypeRed))
        var coorSet5 = MaskMaker.crossMaskSetOfChain(Chain(beeds: set5))
        XCTAssert(coorSet5.containsObject(Coordinate(x: 1, y: 1)), ".containsObject(Coordinate(x: 1, y: 1)")
        XCTAssert(coorSet5.containsObject(Coordinate(x: 1, y: 0)), ".containsObject(Coordinate(x: 1, y: 0)")
        XCTAssert(coorSet5.containsObject(Coordinate(x: 0, y: 1)), ".containsObject(Coordinate(x: 0, y: 1)")
        XCTAssert(coorSet5.containsObject(Coordinate(x: 1, y: 2)), ".containsObject(Coordinate(x: 1, y: 2)")
        XCTAssert(coorSet5.containsObject(Coordinate(x: 2, y: 1)), ".containsObject(Coordinate(x: 2, y: 1)")
        XCTAssert(coorSet5.containsObject(Coordinate(x: 2, y: 2)), ".containsObject(Coordinate(x: 1, y: 1)")
        XCTAssert(coorSet5.containsObject(Coordinate(x: 0, y: 2)), ".containsObject(Coordinate(x: 1, y: 0)")
        XCTAssert(coorSet5.containsObject(Coordinate(x: 1, y: 3)), ".containsObject(Coordinate(x: 0, y: 1)")
        
        
        var beeds2 = Set<Beed>()
        beeds2.addElement(Beed(column: 4, row: 4, beedType: BeedType.BeedTypeRed))
        beeds2.addElement(Beed(column: 5, row: 4, beedType: BeedType.BeedTypeRed))
        var chain2 = Chain(beeds: beeds2)
        var maskSet2 = MaskMaker.crossMaskSetOfChain(chain2)
        
        XCTAssert(maskSet2.containsObject(Coordinate(x: 3, y: 4)),"")
        XCTAssert(maskSet2.containsObject(Coordinate(x: 4, y: 4)),"")
        XCTAssert(maskSet2.containsObject(Coordinate(x: 5, y: 4)),"")
        XCTAssert(maskSet2.containsObject(Coordinate(x: 4, y: 3)),"")
        XCTAssert(maskSet2.containsObject(Coordinate(x: 5, y: 3)),"")
    }
    
    func testCoordinate() {
        var coor = Coordinate(x: 5, y: 6)
        var coor2 = Coordinate(x: 5, y: 6)
        
        XCTAssert(coor==coor2, "")
        
        var beeds = Set<Beed>()
        beeds.addElement(Beed(column: 1, row: 1, beedType: BeedType.BeedTypeRed))
        beeds.addElement(Beed(column: 2, row: 1, beedType: BeedType.BeedTypeRed))
        var coors1 = Coordinate.turnChainToCoordinateSet(Chain(beeds: beeds))
        XCTAssert(coors1.containsObject(Coordinate(x: 1, y: 1)), ".containsObject(Coordinate(x: 1, y: 1)")
        XCTAssert(coors1.containsObject(Coordinate(x: 2, y: 1)), ".containsObject(Coordinate(x: 1, y: 1)")
        XCTAssert(!coors1.containsObject(Coordinate(x: 0, y: 1)), ".containsObject(Coordinate(x: 1, y: 1)")
    }
    
    func testChain() {
        
        var beeds1 = Set<Beed>()
        beeds1.addElement(Beed(column: 1, row: 1, beedType: BeedType.BeedTypeRed))
        beeds1.addElement(Beed(column: 2, row: 1, beedType: BeedType.BeedTypeRed))
        var chain1 = Chain(beeds: beeds1)
        
        var beeds2 = Set<Beed>()
        beeds2.addElement(Beed(column: 4, row: 4, beedType: BeedType.BeedTypeRed))
        beeds2.addElement(Beed(column: 5, row: 4, beedType: BeedType.BeedTypeRed))
        var chain2 = Chain(beeds: beeds2)
        
        var beeds3 = Set<Beed>()
        beeds3.addElement(Beed(column: 3, row: 1, beedType: BeedType.BeedTypeRed))
        beeds3.addElement(Beed(column: 4, row: 1, beedType: BeedType.BeedTypeRed))
        var chain3 = Chain(beeds: beeds3)
        
        var beeds4 = Set<Beed>()
        beeds4.addElement(Beed(column: 2, row: 2, beedType: BeedType.BeedTypeRed))
        beeds4.addElement(Beed(column: 2, row: 3, beedType: BeedType.BeedTypeRed))
        var chain4 = Chain(beeds: beeds4)
        
        XCTAssertEqual(chain1.length,2, "")
        
        XCTAssertTrue(chain1.isConnectedToChain(chain1),"")
        XCTAssertFalse(chain1.isConnectedToChain(chain2), "")
        XCTAssertTrue(chain1.isConnectedToChain(chain3),"")
        XCTAssertTrue(chain1.isConnectedToChain(chain4),"")
    }
    
    func testBoard_ChainsFinder () {
        
        var unprocessedChains = Set<Chain>()
        var beeds1 = Set<Beed>()
        beeds1.addElement(Beed(column: 2, row: 0, beedType: BeedType.BeedTypeGreen))
        beeds1.addElement(Beed(column: 3, row: 0, beedType: BeedType.BeedTypeGreen))
        beeds1.addElement(Beed(column: 1, row: 0, beedType: BeedType.BeedTypeGreen))
        var chain1 = Chain(beeds: beeds1)
        
        var beeds2 = Set<Beed>()
        beeds2.addElement(Beed(column: 2, row: 0, beedType: BeedType.BeedTypeGreen))
        beeds2.addElement(Beed(column: 3, row: 0, beedType: BeedType.BeedTypeGreen))
        beeds2.addElement(Beed(column: 4, row: 0, beedType: BeedType.BeedTypeGreen))
        var chain2 = Chain(beeds: beeds2)
        
        var beeds3 = Set<Beed>()
        beeds3.addElement(Beed(column: 0, row: 1, beedType: BeedType.BeedTypeRed))
        beeds3.addElement(Beed(column: 0, row: 3, beedType: BeedType.BeedTypeRed))
        beeds3.addElement(Beed(column: 0, row: 2, beedType: BeedType.BeedTypeRed))
        var chain3 = Chain(beeds: beeds3)
        
        unprocessedChains.addElement(chain1)
        unprocessedChains.addElement(chain2)
        unprocessedChains.addElement(chain3)
        
        var processedChains = Set<Chain>()
        
        println("start loop")
        while (unprocessedChains.count() != 0){
            (unprocessedChains, processedChains) = Board._mergeChain(unprocessedChains :unprocessedChains, processedChains :processedChains)
        }
        
        var chains = processedChains
        println("#43534553 unprocessedChains : \(unprocessedChains) , processedChains : \(processedChains)")
    }
    
}

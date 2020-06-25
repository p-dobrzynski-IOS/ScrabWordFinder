//
//  ScrabWordFinderTests.swift
//  ScrabWordFinderTests
//
//  Created by Piotr on 29/05/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import XCTest
@testable import ScrabWordFinder

class ScrabWordFinderTests: XCTestCase {
    
    func testLoadFile() {
        let mainVC = EnterWordsViewController()
        let wordsDict = mainVC.loadWordList(fileName: "wordlist")
        
        let wordsInDict = wordsDict.count
        
        XCTAssertEqual(wordsInDict, 10001)
        XCTAssertEqual(wordsDict[382], "angle")
    }
}

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
        let enterVC = EnterWordsViewController()
        let wordsDict: [String] = enterVC.loadWordList(fileName: "wordlist")
        
        let wordsInDict: Int = wordsDict.count
        
        XCTAssertEqual(wordsInDict, 10001)
        XCTAssertEqual(wordsDict[382], "angle")
    }
    
    func testValidateLetters() {
        
        let enterVC = EnterWordsViewController()
        
        let str: String = "abcdefghijklmnopqrstuvwxyz"
        let characterArray: [Character] = Array(str.uppercased())
        
        let maxLettersInWord: Int = 10
        
        let rangeOfWordsInAlphabet = characterArray.count-maxLettersInWord
        
        for letterIndex in 0..<rangeOfWordsInAlphabet {
            
            let characters = Array(characterArray[letterIndex..<(letterIndex+maxLettersInWord)])
            
            XCTAssertTrue(enterVC.validateLetters(of: characters), "Letters not valid")
        }
        
    }
}

//
//  Constants.swift
//  ScrabWordFinder
//
//  Created by Piotr on 04/06/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import Foundation

struct Constants {

    static let mainToResultSegue = "MainToResult"

    struct Colors {
        static let scrabbleBlockBackgroundColor = "scrabbleBlockBackgroundColor"
        static let scrabbleBlockLetterColor = "scrabbleBlockLetterColor"
        static let scrabbleErrorFrameColor = "scrabbleErrorFrameColor"
    }
    
    static let pointsAlphabet: [(char: Character, value: Int)] =
        [
            (char: "A", value: 1),
            (char: "B", value: 3),
            (char: "C", value: 3),
            (char: "D", value: 2),
            (char: "E", value: 1),
            (char: "F", value: 4),
            (char: "G", value: 2),
            (char: "H", value: 4),
            (char: "I", value: 1),
            (char: "J", value: 8),
            (char: "K", value: 5),
            (char: "L", value: 1),
            (char: "M", value: 3),
            (char: "N", value: 1),
            (char: "O", value: 1),
            (char: "P", value: 3),
            (char: "Q", value: 10),
            (char: "R", value: 1),
            (char: "S", value: 1),
            (char: "T", value: 1),
            (char: "U", value: 1),
            (char: "V", value: 4),
            (char: "W", value: 4),
            (char: "X", value: 8),
            (char: "Y", value: 4),
            (char: "Z", value: 10)
    ]
}

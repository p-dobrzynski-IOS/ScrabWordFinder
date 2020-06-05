//
//  TrieAlgorithm.swift
//  ScrabWordFinder
//
//  Created by Piotr on 01/06/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import Foundation

struct ScrableAlgorithm {

    let alphabet: [(char: Character, value: Int)] =
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

    func findValidWords(in dictionary: [String], with letters: [Character]) -> [(points: Int, words: [String])] {

        var validWords = [(word: String, value: Int)]()

        for dictWord in dictionary {
            var temp = dictWord
            for char in letters {
                temp = temp.filter { $0 != char }
                if temp.isEmpty {
                    let wordValue = getWordValue(fromWord: dictWord)
                    validWords.append((word: dictWord, value: wordValue))
                    break
                }
            }
        }

        // Sorting words by alphabetical order and value
        let wordsPointsArray: [(points: Int, words: [String])] = getsortedWords(from: validWords)

        return wordsPointsArray
    }

    private func getWordValue(fromWord word: String) -> Int {

        var wordValue: Int = 0
        for char in word.uppercased() {
            if let index = alphabet.firstIndex(where: { $0.char == char }) {
                wordValue += alphabet[index].value
            }
        }
        return wordValue
    }

    private func getsortedWords(from validWordsArray: [(word: String, value: Int)]) -> [(points: Int, words: [String])] {

        let sortedWords = validWordsArray.sorted { (tuple1, tuple2) -> Bool in
            if (tuple1.value != tuple2.value) { // if it's not the same section sort by section
                return tuple1.value > tuple2.value
            } else { // if it the same section sort by order.
                return tuple1.word < tuple2.word
            }
        }
        
        var wordsArray: [(points: Int, words: [String])] = [(points: sortedWords[0].value, words: [sortedWords[0].word])]

        var counter: Int = 0
        for index in 1...sortedWords.count - 1 {
            if sortedWords[index].value == sortedWords[index-1].value {
                wordsArray[counter].words.append(sortedWords[index].word)
            } else {
                counter += 1
                wordsArray.append(((sortedWords[index].value), [sortedWords[index].word]))
            }
        }

        return wordsArray
    }

}

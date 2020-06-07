//
//  TrieAlgorithm.swift
//  ScrabWordFinder
//
//  Created by Piotr on 01/06/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import Foundation

struct ScrableAlgorithm {

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
            if let index = Constants.pointsAlphabet.firstIndex(where: { $0.char == char }) {
                wordValue += Constants.pointsAlphabet[index].value
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

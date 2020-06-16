//
//  TrieAlgorithm.swift
//  ScrabWordFinder
//
//  Created by Piotr on 01/06/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import Foundation

struct ScrableAlgorithm {

    func findValidWords(in dictionary: [String], with letters: [Character]) -> [ValidWords] {

        var validWords = [SingleValidWord]()

        for dictWord in dictionary {
            var temp = dictWord
            for char in letters {
                temp = temp.filter { $0 != char }
                if temp.isEmpty {
                    let wordValue = getWordValue(fromWord: dictWord)
                    validWords.append(SingleValidWord(word: dictWord, value: wordValue, letters: letters))

//                     validWords.append((word: dictWord, value: wordValue))
                    break
                }
            }
        }

        // Sorting words by alphabetical order and value
        let wordsPointsArray: [ValidWords] = getsortedWords(from: validWords)

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

    private func getsortedWords(from validWordsArray: [SingleValidWord]) -> [ValidWords] {

        let sortedWords = validWordsArray.sorted { (valid1, valid2) -> Bool in
            if valid1.value != valid2.value { // if it's not the same section sort by section
                return valid1.value > valid2.value
            } else { // if it the same section sort by order.
                return valid1.word < valid2.word
            }
        }
        
        var wordsArray: [ValidWords] = [ValidWords(points: sortedWords[0].value, words: [sortedWords[0].word], letters: sortedWords[0].letters)]

        var counter: Int = 0
        for index in 1...sortedWords.count - 1 {
            if sortedWords[index].value == sortedWords[index-1].value {
                wordsArray[counter].words.append(sortedWords[index].word)
            } else {
                counter += 1
                wordsArray.append(ValidWords(points: sortedWords[index].value, words: [sortedWords[index].word], letters: sortedWords[index].letters))
            }
        }

        return wordsArray
    }

}

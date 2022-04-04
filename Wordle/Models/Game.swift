//
//  Game.swift
//  Wordle
//
//  Created by Maertens Yann-Christophe on 04/04/22.
//

import Foundation

struct Game {
    var board = [WordleSquare](repeating: WordleSquare(), count: 25)
    var startLineIndex = 0
    var currentLetterIndex = 0
    var currentLanguage: GameLanguage?
    var word = ""
    var keyboard = [GameKeyboard]()
    var lettersUsed = [String]()
    
    var wordArray: [String] {
        return Array(word).map { String($0) }
    }
    
    var currentLineRange: Range<Int> {
        return startLineIndex ..< (startLineIndex + 5)
    }
    
    var currentLine: [WordleSquare] {
        return Array(board[currentLineRange])
    }
    
    var writtenWord: String {
        return currentLine.map { $0.letter }.joined()
    }
}

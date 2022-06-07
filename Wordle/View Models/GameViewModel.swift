//
//  GameViewModelù.swift
//  Wordle
//
//  Created by Maertens Yann-Christophe on 03/04/22.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var game = Game()
    
    init() {
        resetGame(.france)
    }
    
    func resetGame(_ language: GameLanguage) {
        game = Game()
        game.currentLanguage = language
        setUpKeyboard(language)
        if let currentLanguage = game.currentLanguage {
            game.word = Bundle.main.words(currentLanguage.data).randomElement()!
        }
        print(game.word)
    }
    
    func setUpKeyboard(_ language: GameLanguage) {
        let keyboardKeys = Array(language.keyboard)
        game.keyboard = [GameKeyboard](repeating: GameKeyboard(), count: language.keyboard.count)
        for index in game.keyboard.indices {
            game.keyboard[index].character = String(keyboardKeys[index])
        }
    }
    
    func addLetter(_ letter: String) {
        if !isLineFull {
            game.board[game.currentLetterIndex].letter = letter
            game.currentLetterIndex += 1
        }
    }
    
    func removeLastLetter() {
        guard game.board.indices.contains(game.currentLetterIndex - 1) else { return }
        if game.currentLetterIndex > game.startLineIndex {
            game.board[game.currentLetterIndex - 1].letter = ""
            game.currentLetterIndex -= 1
        }
    }
    
    var isWordRight: Bool { game.writtenWord == game.word }
    
    var rightLettersIndices: [Int] {
        var result = [Int]()
        for index in game.currentLine.indices {
            if game.wordArray[index] == game.currentLine[index].letter {
                result.append(index)
            }
        }
        return result
    }
    
    var misplacedLettersIndices: [Int] {
        var result = [Int]()
        for index in game.currentLine.indices {
            if game.word.contains(game.currentLine[index].letter) {
                result.append(index)
            }
        }
        return result
    }
    
    var wrongLettersIndices: [Int] {
        var result = [Int]()
        for index in game.currentLine.indices {
            if !rightLettersIndices.contains(index) && !misplacedLettersIndices.contains(index) {
                result.append(index)
            }
        }
        return result
    }
    
    func changeBoardColors() {
        for index in misplacedLettersIndices {
            let colorIndex = index + game.startLineIndex
            game.board[colorIndex].backgroundColor = .customYellow
        }
        
        for index in rightLettersIndices {
            let colorIndex = index + game.startLineIndex
            game.board[colorIndex].backgroundColor = .customGreen
        }
        
        for index in wrongLettersIndices {
            let colorIndex = index + game.startLineIndex
            game.board[colorIndex].backgroundColor = .gray
            game.lettersUsed.append(game.board[colorIndex].letter)
        }
    }
    
    func updateCurrentLetterIndex() {
        guard let firstEmptyLetterIndex = game.board.firstIndex(where: { $0.letter.isEmpty }) else { return }
        game.currentLetterIndex = firstEmptyLetterIndex
    }
    
    func colorKeyboard() {
        for index in game.keyboard.indices {
            if game.lettersUsed.contains(game.keyboard[index].character) {
                game.keyboard[index].backgroundColor = .customGray
            }
        }
    }
    func checkWord(_ isPresented: inout Bool) {
        
        if isWordRight {
            for index in game.currentLineRange {
                game.board[index].backgroundColor = .customGreen
            }
            isPresented.toggle()
        } else {
            if game.startLineIndex != 20 {
                changeBoardColors()
                colorKeyboard()
                updateCurrentLetterIndex()
                game.startLineIndex += 5
            } else {
                isPresented.toggle()
            }
        }
    }
    
    var isLineFull: Bool {
        print(game.currentLine.allSatisfy({ !$0.letter.isEmpty }))
        return game.currentLine.allSatisfy({ !$0.letter.isEmpty })
    }
}

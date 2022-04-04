//
//  GameLanguage.swift
//  Wordle
//
//  Created by Maertens Yann-Christophe on 04/04/22.
//

import Foundation

enum GameLanguage: String, CaseIterable {
    case unitedStates = "United States"
    case france = "France"
    case polynesia = "Polynesia"
    
    var keyboard: String {
        switch self {
        case .unitedStates:
            return "azertyuiopqsdfghjklmwxcvbn"
        case .france:
            return "azertyuiopqsdfghjklmwxcvbn"
        case .polynesia:
            return "azertyuiopqsdfghjklmwxcvbn'"
        }
    }
    
    var flag: String {
        switch self {
        case .unitedStates:
            return "🇺🇸"
        case .france:
            return "🇫🇷"
        case .polynesia:
            return "🇵🇫"
        }
    }
    
    var data: String {
        switch self {
        case .unitedStates:
            return "words.txt"
        case .france:
            return "mots.txt"
        case .polynesia:
            return "parau.txt"
        }
    }
}

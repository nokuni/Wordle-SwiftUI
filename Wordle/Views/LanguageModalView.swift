//
//  LanguageModalView.swift
//  Wordle
//
//  Created by Maertens Yann-Christophe on 04/04/22.
//

import SwiftUI

struct LanguageModalView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: GameViewModel
    @State var isAlertPresented = false
    var body: some View {
        List(GameLanguage.allCases, id: \.self) { language in
            Button(action: {
                if viewModel.game.startLineIndex > 0 {
                    isAlertPresented.toggle()
                } else {
                    viewModel.game.currentLanguage = language
                    viewModel.resetGame(language)
                    dismiss()
                }
            }) {
                HStack {
                    Text("\(language.flag) \(language.rawValue)")
                }
            }
            .alert("By changing the words, the game will reset, are you sure?", isPresented: $isAlertPresented) {
                Button("Yes", role: .destructive) {
                    viewModel.game.currentLanguage = language
                    viewModel.resetGame(language)
                    dismiss()
                }
                Button("No", role: .cancel) { }
            }
        }
    }
}

struct LanguageModalView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageModalView(viewModel: GameViewModel())
    }
}

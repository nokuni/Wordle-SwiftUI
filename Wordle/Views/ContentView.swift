//
//  ContentView.swift
//  Wordle
//
//  Created by Maertens Yann-Christophe on 03/04/22.
//

import SwiftUI

struct ContentView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 5)
    @StateObject var viewModel = GameViewModel()
    @State var isAlertPresented = false
    @State var isLanguageListPresented = false
    var body: some View {
        GeometryReader { geo in
            VStack {
                ChangeLanguageButtonView(size: geo.size, viewModel: viewModel, isLanguageListPresented: $isLanguageListPresented)
                Text("Wordle")
                    .font(.system(size: geo.size.width * 0.06, weight: .bold, design: .rounded))
                GameBoardView(size: geo.size, viewModel: viewModel)
                ValidateButtonView(size: geo.size, viewModel: viewModel, isAlertPresented: $isAlertPresented)
                
                CustomKeyboardView(viewModel: viewModel)
            }
            .sheet(isPresented: $isLanguageListPresented) {
                LanguageModalView(viewModel: viewModel)
            }
            .alert(viewModel.isWordRight ? "\(NSLocalizedString("Congratulation", comment: ""))!" : "\(NSLocalizedString("Game Over", comment: ""))! \(NSLocalizedString("The word was", comment: "")) \(viewModel.game.word.uppercased())", isPresented: $isAlertPresented) {
                Button("\(NSLocalizedString("New Word", comment: ""))", role: .cancel) {
                    if let currentLanguage = viewModel.game.currentLanguage {
                        viewModel.resetGame(currentLanguage)
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
    @State var isPresented = false
    @State var isScreenCoverPresented = false
    var body: some View {
        GeometryReader { geo in
            VStack {
                Button(action: {
                    isScreenCoverPresented.toggle()
                }) {
                    HStack {
                        if let currentLanguage = viewModel.game.currentLanguage {
                            Text("\(currentLanguage.flag) \(currentLanguage.rawValue)")
                                .foregroundColor(.black)
                                .padding(5)
                                .background(Color.white.cornerRadius(5))
                        }
                        Text("Changer langue")
                            .foregroundColor(.white)
                        Image("flag")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .scaledToFit()
                    }
                    .padding(5)
                    .frame(width: geo.size.width, height: geo.size.width * 0.1)
                    .background(Color.teal.cornerRadius(5))
                }
                Text("Wordle")
                    .font(.system(size: geo.size.width * 0.06, weight: .bold, design: .rounded))
                GameBoardView(size: geo.size, viewModel: viewModel)
                Button(action: {
                    viewModel.checkWord(&isPresented)
                }) {
                    Text("Valider")
                        .foregroundColor(.white)
                        .font(.system(size: geo.size.width * 0.05, weight: .bold, design: .rounded))
                        .padding()
                        .background(
                            ZStack {
                                !viewModel.isLineFull ? Color.customGray : Color.customGreen
                            }
                                .cornerRadius(5)
                        )
                }
                .disabled(!viewModel.isLineFull)
                
                CustomKeyboardView(viewModel: viewModel)
            }
            .fullScreenCover(isPresented: $isScreenCoverPresented, content: {
                LanguageModalView(viewModel: viewModel)
            })
            .alert(viewModel.isWordRight ? "Bravo!" : "Perdu! Le mot était \(viewModel.game.word.uppercased())", isPresented: $isPresented) {
                Button("Nouveau Mot", role: .cancel) {
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

struct GameBoardView: View {
    var grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 5)
    var size: CGSize
    var viewModel: GameViewModel
    var body: some View {
        ZStack(alignment: .top) {
            LazyVGrid(columns: grid, spacing: 0) {
                ForEach(viewModel.game.board.indices, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(viewModel.game.board[index].backgroundColor)
                            .padding(2)
                            .frame(width: size.width * 0.2, height: size.width * 0.2)
                        Text(viewModel.game.board[index].letter.uppercased())
                            .foregroundColor(.white)
                            .font(.system(size: size.width * 0.1, weight: .bold, design: .rounded))
                    }
                }
            }
        }
    }
}

extension Bundle {
    func words(_ filename: String) -> Set<String> {
        guard let url = url(forResource: filename, withExtension: nil) else {
            return []
        }
        guard let contents = try? String(contentsOf: url) else { return [] }
        
        return Set(contents.components(separatedBy: "\n"))
    }
}

struct LanguageModalView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: GameViewModel
    var body: some View {
        List(GameLanguage.allCases, id: \.self) { language in
            Button(action: {
                viewModel.game.currentLanguage = language
                viewModel.resetGame(language)
                dismiss()
            }) {
                HStack {
                    Text("\(language.flag) \(language.rawValue)")
                }
            }
        }
    }
}

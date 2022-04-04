//
//  CustomKeyboardView.swift
//  Wordle
//
//  Created by Maertens Yann-Christophe on 03/04/22.
//

import SwiftUI

struct CustomKeyboardView: View {
    var grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 10)
    @ObservedObject var viewModel: GameViewModel
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    LazyVGrid(columns: grid, spacing: 0) {
                        ForEach(viewModel.game.keyboard.indices, id: \.self) { index in
                            Button(action: {
                                viewModel.addLetter(String(viewModel.game.keyboard[index].character))
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(viewModel.game.keyboard[index].backgroundColor)
                                        .padding(1)
                                        .frame(width: geo.size.width * 0.1, height: geo.size.width * 0.2)
                                    Text(String(viewModel.game.keyboard[index].character))
                                        .font(.system(size: geo.size.width * 0.06, weight: .regular, design: .rounded))
                                        .foregroundColor(.primary)
                                }
                            }
                            .disabled(viewModel.game.keyboard[index].backgroundColor == .customGray)
                        }
                    }
                }
                .background(
                    Button(action: {
                        viewModel.removeLastLetter()
                    }) {
                        Image("backspace")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .font(.system(size: geo.size.width * 0.05, weight: .bold, design: .rounded))
                            .padding()
                            .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)
                            .background(Color(UIColor.systemGray6).cornerRadius(5))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    }
                )
                .background(
                    Color(UIColor.systemGray5)
                        .cornerRadius(5)
                )
            }
        }
    }
}

struct CustomKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        CustomKeyboardView(viewModel: GameViewModel())
    }
}

//
//  GameBoardView.swift
//  Wordle
//
//  Created by Maertens Yann-Christophe on 04/04/22.
//

import SwiftUI

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

struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView(size: CGSize.screen, viewModel: GameViewModel())
    }
}

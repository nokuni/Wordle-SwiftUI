//
//  ChangeLanguageView.swift
//  Wordle
//
//  Created by Maertens Yann-Christophe on 04/04/22.
//

import SwiftUI

struct ChangeLanguageButtonView: View {
    var size: CGSize
    @ObservedObject var viewModel: GameViewModel
    @Binding var isLanguageListPresented: Bool
    var body: some View {
        Button(action: {
            isLanguageListPresented.toggle()
        }) {
            HStack {
                if let currentLanguage = viewModel.game.currentLanguage {
                    Text("\(currentLanguage.flag) \(currentLanguage.rawValue)")
                        .foregroundColor(.black)
                        .padding(5)
                        .background(Color.white.cornerRadius(5))
                }
                Text("\(NSLocalizedString("Change Words", comment: ""))")
                    .foregroundColor(.white)
                Image("flag")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .scaledToFit()
            }
            .padding(5)
            .frame(width: size.width, height: size.width * 0.1)
            .background(Color.teal.cornerRadius(5))
        }
    }
}

struct ChangeLanguageButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeLanguageButtonView(size: CGSize.screen, viewModel: GameViewModel(), isLanguageListPresented: .constant(false))
    }
}

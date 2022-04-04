//
//  ValidateButtonView.swift
//  Wordle
//
//  Created by Maertens Yann-Christophe on 04/04/22.
//

import SwiftUI

struct ValidateButtonView: View {
    var size: CGSize
    @ObservedObject var viewModel: GameViewModel
    @Binding var isAlertPresented: Bool
    var body: some View {
        Button(action: {
            viewModel.checkWord(&isAlertPresented)
        }) {
            Text("\(NSLocalizedString("Validate", comment: ""))")
                .foregroundColor(.white)
                .font(.system(size: size.width * 0.05, weight: .bold, design: .rounded))
                .padding()
                .background(
                    ZStack {
                        !viewModel.isLineFull ? Color.customGray : Color.customGreen
                    }
                        .cornerRadius(5)
                )
        }
        .disabled(!viewModel.isLineFull)
    }
}

struct ValidateButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ValidateButtonView(size: CGSize.screen, viewModel: GameViewModel(), isAlertPresented: .constant(false))
    }
}

//
//  TransferView.swift
//  head2headBeej
//
//  Created by Fiumefreddo, Frank (Berkeley Heights) on 7/13/26.
//
import SwiftUI

struct TransferView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    var body: some View {
        ZStack{
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            
            VStack{
                Text(gameViewModel.getCurrentPlayer()?.name ?? "")
                    .font(.title)
                    .foregroundStyle(Color.white)
                Button("Ready"){
                    gameViewModel.transfer = false
                }
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(
                    LinearGradient(
                        colors: [Color(red: 0.11, green: 0.47, blue: 0.88), Color(red: 0.05, green: 0.34, blue: 0.77)],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    in: RoundedRectangle(cornerRadius: 22, style: .continuous)
                )
            }
        }
       
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    TransferView()
        .environmentObject(GameViewModel())
}

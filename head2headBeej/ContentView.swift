//
//  ContentView.swift
//  head2headBeej
//
//  Created by Fiumefreddo, Frank (Berkeley Heights) on 7/13/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = GameViewModel()
    @State var hasStarted = false
    var body: some View {
      if hasStarted{
        GameView()
        .environmentObject(viewModel)
      }
      else{
        PlayerSetupView(hasStarted: $hasStarted)
        .environmentObject(viewModel)
      }
    }
}

#Preview {
    ContentView()
}

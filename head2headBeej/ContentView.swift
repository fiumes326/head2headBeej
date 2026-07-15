//
//  ContentView.swift
//  head2headBeej
//
//  Created by Fiumefreddo, Frank (Berkeley Heights) on 7/13/26.
//

import SwiftUI

struct ContentView: View {
    @State var hasStarted = false
    @StateObject private var viewModel = GameViewModel()
    var body: some View {
      if hasStarted{
        GameView(hasStarted: $hasStarted)
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

//
//  ContentView.swift
//  Useless Facts
//

import SwiftUI

struct ContentView: View {

  @StateObject private var viewModel: ViewModel = ViewModel()

  var body: some View {
    VStack {
      Spacer()
      Text(viewModel.fact.text)
        .font(.largeTitle)
        .bold()
        .padding()
      Spacer()
      HStack {
        Spacer()
        Button(action: {
          Task.init { await viewModel.start() }
        }, label: {
          Image(systemName: "arrow.clockwise")
            .font(.largeTitle)
        })
        .padding()
      }
    }.task {
      await viewModel.start()
    }
  }
}

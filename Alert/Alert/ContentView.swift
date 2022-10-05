//
//  ContentView.swift
//  Alert
//
//  Created by Ale Patrón on 10/4/22.
//

import SwiftUI

struct ContentView: View {

  @State private var showAlert: Bool = false
  @State private var hobby: Hobby? = nil {
    didSet {
      if hobby != nil {
        showAlert = true
      }
    }
  }

  var body: some View {
    VStack(spacing: 8) {
      Button("🎾") { hobby = Hobby(name: "playing tennis") }
      Button("🎥") { hobby = Hobby(name: "watching YouTube videos") }
      Button("📖") { hobby = Hobby(name: "reading books") }
    }
    .padding()
    .alert(
      "My favorite hobby is...",
      isPresented: $showAlert,
      presenting: hobby,
      actions: { _ in },
      message: { hobby in
        Text(hobby.name)
      }
    )
  }
}

struct Hobby: Identifiable {
  let id: UUID = UUID()
  let name: String
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

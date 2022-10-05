//
//  ContentView.swift
//  Link
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    Link(destination: URL(string: "https://youtube.com/alepatron")!, label: {
      Label("Watch my videos on YouTube!", systemImage: "play.rectangle.fill")
        .font(.system(size: 18).bold())
        .padding(6)
        .foregroundColor(.white)
        .background(Color.red)
        .cornerRadius(6)
    })
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

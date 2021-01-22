//
//  Music_SearchApp.swift
//  Music Search
//
//  Created by Alejandrina Patrón López on 1/18/21.
//

import SwiftUI

@main
struct Music_SearchApp: App {
    var body: some Scene {
        WindowGroup {
          ContentView(viewModel: SongListViewModel())
        }
    }
}

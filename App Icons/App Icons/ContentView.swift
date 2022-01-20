//
//  ContentView.swift
//  App Icons
//

import SwiftUI

struct ContentView: View {

  @StateObject var appSettings: AppSettings = AppSettings()

  var body: some View {
    NavigationView {
      List(1...20, id: \.self) { i in
        Text("\(i)")
      }
      .toolbar {
        ToolbarItem {
          NavigationLink(destination: {
            IconsListView()
              .navigationBarTitleDisplayMode(.inline)
              .environmentObject(appSettings)
          }) {
            Image(systemName: "gear")
          }
        }
      }
      .navigationTitle("My App")
    }
  }
}

struct IconsListView: View {

  @EnvironmentObject var appSettings: AppSettings

  var body: some View {
    Form {
      Picker("App Icon", selection: $appSettings.iconIndex) {
        ForEach(appSettings.icons.indices, id: \.self) { index in
          IconRow(icon: appSettings.icons[index])
            .tag(index)
        }
      }
      .pickerStyle(.inline)
      .onChange(of: appSettings.iconIndex) { newIndex in
        guard UIApplication.shared.supportsAlternateIcons else {
          print("App does not support alternate icons")
          return
        }

        let currentIndex = appSettings.icons.firstIndex(where: { icon in
          return icon.iconName == appSettings.currentIconName
        }) ?? 0
        guard newIndex != currentIndex else { return }
        let newIconSelection = appSettings.icons[newIndex].iconName
        UIApplication.shared.setAlternateIconName(newIconSelection) { error in
          if let error = error {
            print(error.localizedDescription)
          }
        }
      }
    }
  }
}

struct IconRow: View {

  public let icon: Icon

  var body: some View {
    HStack(alignment: .center) {
      Image(uiImage: icon.image ?? UIImage())
        .resizable()
        .frame(width: 60, height: 60)
        .cornerRadius(10)
        .padding(.trailing)
      Text(icon.displayName)
        .bold()
    }
    .padding(8)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

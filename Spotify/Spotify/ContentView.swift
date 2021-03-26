//
//  ContentView.swift
//  Spotify
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea(.all)
      VStack {
        HStack {
          Button(action: {}, label: {
            Image(systemName: "chevron.down")
          })
          .padding([.leading, .trailing])

          Spacer()

          Text("After Hours")
            .font(.callout)
            .bold()
            .lineLimit(1)

          Spacer()

          Button(action: {}, label: {
            Image(systemName: "ellipsis")
          })
          .padding([.leading, .trailing])
        }
        .padding(.top)

        Spacer()

        Image("album_cover")
          .resizable()
          .frame(width: 350, height: 350)

        Spacer()

        HStack {
          VStack(alignment: .leading) {
            Text("Blinding Lights")
              .font(.largeTitle)
              .bold()
              .lineLimit(1)
            Text("The Weeknd")
              .lineLimit(1)
          }
          Spacer()

          Button(action: {}, label: {
            Image(systemName: "heart.fill")
          })
          .font(.title)
          .padding(.trailing)
        }
        .padding([.leading, .trailing])

        ProgressView(value: 0.4)
          .padding([.leading, .trailing])

        MediaControls()
          .padding([.leading, .trailing, .top], 20)
          .padding(.bottom, 40)
      }
      .foregroundColor(.white)
    }
  }
}

struct MediaControls: View {
  var body: some View {
    HStack {
      Button(action: {}, label: {
        Image(systemName: "shuffle")
      })
      .foregroundColor(.green)
      .padding([.leading, .trailing])

      Spacer()

      Button(action: {}, label: {
        Image(systemName: "backward.end.fill")
      })
      .font(.largeTitle)

      Button(action: {}, label: {
        Image(systemName: "play.circle.fill")
      })
      .font(.system(size: 65))
      .padding([.leading, .trailing])

      Button(action: {}, label: {
        Image(systemName: "forward.end.fill")
      })
      .font(.largeTitle)

      Spacer()

      Button(action: {}, label: {
        Image(systemName: "repeat")
      })
      .padding([.leading, .trailing])
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

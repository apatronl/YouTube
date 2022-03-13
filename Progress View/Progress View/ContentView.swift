//
//  ContentView.swift
//  Progress View
//

import SwiftUI

struct ContentView: View {
  @State private var progress: Double = 0
  private let total: Double = 1

  @State private var dataTask: URLSessionDataTask?
  @State private var observation: NSKeyValueObservation?
  @State private var image: UIImage?

  var body: some View {
    VStack {
      ZStack {
        if image == nil {
          ProgressView("Downloading image...", value: progress, total: total)
            .progressViewStyle(LinearProgressViewStyle())
            .padding()
        } else {
          Image(uiImage: image!)
            .resizable()
        }
      }

      Spacer()
      HStack {
        Spacer()
        Button(action: {
          reset()
          downloadPhoto()
        }) {
          Image(systemName: "arrow.clockwise")
        }
        .font(.largeTitle)
      }
      .padding()
    }
    .onAppear(perform: downloadPhoto)
  }

  private func downloadPhoto() {
    guard let url = URL(string: "https://source.unsplash.com/random/4000x8000") else { return }

    dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
      guard let data = data else { return }
      DispatchQueue.main.async {
        image = UIImage(data: data)
      }
    }
    observation = dataTask?.progress.observe(\.fractionCompleted) { observationProgress, _ in
      DispatchQueue.main.async {
        progress = observationProgress.fractionCompleted
      }
    }
    dataTask?.resume()
  }

  private func reset() {
    observation?.invalidate()
    dataTask?.cancel()
    progress = 0
    image = nil
  }
}

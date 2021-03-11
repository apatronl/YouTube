//
//  ContentView.swift
//  JSON Map
//

import MapKit
import SwiftUI

struct ContentView: View {

  @State private var locations: [Location] = []

  @State private var coordinateRegion = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 19.43, longitude: -99.13),
    span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
  )

  var body: some View {
    Map(
      coordinateRegion: $coordinateRegion,
      annotationItems: locations
    ) { location in
      MapAnnotation(
        coordinate: CLLocationCoordinate2D(
          latitude: location.latitude,
          longitude: location.longitude
        )
      ) {
        VStack {
          Text(location.name)
            .font(.caption2)
            .bold()
          Image(systemName: "star.fill")
            .font(.title2)
            .foregroundColor(.red)
            .shadow(radius: 1)
        }
      }
    }
    .onAppear(perform: readFile)
  }

  private func readFile() {
    if let url = Bundle.main.url(forResource: "locations", withExtension: "json"),
       let data = try? Data(contentsOf: url) {
      let decoder = JSONDecoder()
      if let jsonData = try? decoder.decode(JSONData.self, from: data) {
        self.locations = jsonData.locations
      }
    }
  }
}

struct JSONData: Decodable {
  let locations: [Location]
}

struct Location: Decodable, Identifiable {
  let id: Int
  let name: String
  let latitude: Double
  let longitude: Double
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

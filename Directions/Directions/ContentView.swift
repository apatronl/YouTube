//
//  ContentView.swift
//  Directions
//

import MapKit
import SwiftUI
import UIKit

struct ContentView: View {

  @State private var directions: [String] = []
  @State private var showDirections = false

  var body: some View {
    VStack {
      MapView(directions: $directions)

      Button(action: {
        self.showDirections.toggle()
      }, label: {
        Text("Show directions")
      })
      .disabled(directions.isEmpty)
      .padding()
    }.sheet(isPresented: $showDirections, content: {
      VStack(spacing: 0) {
        Text("Directions")
          .font(.largeTitle)
          .bold()
          .padding()

        Divider().background(Color(UIColor.systemBlue))

        List(0..<self.directions.count, id: \.self) { i in
          Text(self.directions[i]).padding()
        }
      }
    })
  }
}

struct MapView: UIViewRepresentable {

  typealias UIViewType = MKMapView

  @Binding var directions: [String]

  func makeCoordinator() -> MapViewCoordinator {
    return MapViewCoordinator()
  }

  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator

    let region = MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: 40.71, longitude: -74),
      span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    mapView.setRegion(region, animated: true)

    // NYC
    let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.71, longitude: -74))

    // Boston
    let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.36, longitude: -71.05))

    let request = MKDirections.Request()
    request.source = MKMapItem(placemark: p1)
    request.destination = MKMapItem(placemark: p2)
    request.transportType = .automobile

    let directions = MKDirections(request: request)
    directions.calculate { response, error in
      guard let route = response?.routes.first else { return }
      mapView.addAnnotations([p1, p2])
      mapView.addOverlay(route.polyline)
      mapView.setVisibleMapRect(
        route.polyline.boundingMapRect,
        edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
        animated: true)
      self.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
    }
    return mapView
  }

  func updateUIView(_ uiView: MKMapView, context: Context) {
  }

  class MapViewCoordinator: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let renderer = MKPolylineRenderer(overlay: overlay)
      renderer.strokeColor = .systemBlue
      renderer.lineWidth = 5
      return renderer
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

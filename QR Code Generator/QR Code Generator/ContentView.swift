//
//  ContentView.swift
//  QR Code Generator
//

import SwiftUI

// https://www.youtube.com/channel/UCvsJ3k3CFcRq3eJnUoU3u2w

struct ContentView: View {

  @State private var urlInput: String = ""
  @State private var qrCode: QRCode?

  private let qrCodeGenerator = QRCodeGenerator()
  @StateObject private var imageSaver = ImageSaver()

  var body: some View {
    NavigationView {
      GeometryReader { geometry in
        VStack {
          HStack {
            TextField("Enter url:", text: $urlInput)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .textContentType(.URL)
              .keyboardType(.URL)

            Button("Generate") {
              UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
              qrCode = qrCodeGenerator.generateQRCode(forUrlString: urlInput)
              urlInput = ""
            }
            .disabled(urlInput.isEmpty)
            .padding(.leading)
          }

          Spacer()

          if qrCode == nil {
            EmptyStateView(width: geometry.size.width)
          } else {
            QRCodeView(qrCode: qrCode!, width: geometry.size.width)
          }

          Spacer()
        }
        .padding()
        .navigationBarTitle("QR Code")
        .navigationBarItems(trailing: Button(action: {
          assert(qrCode != nil, "Cannot save nil QR code image")
          imageSaver.saveImage(qrCode!.uiImage)
        }) {
          Image(systemName: "square.and.arrow.down")
        }
        .disabled(qrCode == nil))
        .alert(item: $imageSaver.saveResult) { saveResult in
          return alert(forSaveStatus: saveResult.saveStatus)
        }
      }
    }
  }

  private func alert(forSaveStatus saveStatus: ImageSaveStatus) -> Alert {
    switch saveStatus {
    case .success:
      return Alert(
        title: Text("Success!"),
        message: Text("The QR code was saved to your photo library.")
      )
    case .error:
      return Alert(
        title: Text("Oops!"),
        message: Text("An error occurred while saving your QR code.")
      )
    case .libraryPermissionDenied:
      return Alert(
        title: Text("Oops!"),
        message: Text("This app needs permission to add photos to your library."),
        primaryButton: .cancel(Text("Ok")),
        secondaryButton: .default(Text("Open settings")) {
          guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
          UIApplication.shared.open(settingsUrl)
        }
      )
    }
  }
}

struct QRCodeView: View {
  let qrCode: QRCode
  let width: CGFloat

  var body: some View {
    VStack {
      Label("QR code for \(qrCode.urlString):", systemImage: "qrcode.viewfinder")
        .lineLimit(3)
      Image(uiImage: qrCode.uiImage)
        .resizable()
        .frame(width: width * 2 / 3, height: width * 2 / 3)
    }
  }
}

struct EmptyStateView: View {

  let width: CGFloat

  private var imageLength: CGFloat {
    width / 2.5
  }

  var body: some View {
    VStack {
      Image(systemName: "qrcode")
        .resizable()
        .frame(width: imageLength, height: imageLength)

      Text("Create your own QR code")
        .padding(.top)
    }
    .foregroundColor(Color(UIColor.systemGray))
  }
}

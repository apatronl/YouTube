//
//  Bitcoin_PriceApp.swift
//  Bitcoin Price
//
//  Created by Alejandrina Patrón López on 8/10/21.
//

import SwiftUI

@main
struct Bitcoin_PriceApp: App {
  var body: some Scene {
    WindowGroup {
      BitcoinPriceView(viewModel: BitcoinPriceViewModel())
    }
  }
}

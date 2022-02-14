//
//  ViewModel.swift
//  Useless Facts
//

import Foundation

@MainActor
public final class ViewModel: ObservableObject {

  @Published public private(set) var fact = Fact(text: "Loading...")

  public func start() async {
    do {
      fact = try await getFact()
    } catch {
      fact = Fact(text: error.localizedDescription)
    }
  }

  private func getFact() async throws -> Fact {
    guard let url = URL(string: "https://uselessfacts.jsph.pl/random.json?language=en") else {
      throw URLError(.unknown)
    }

    let (data, _) = try await URLSession.shared.data(from: url)
    let fact = try JSONDecoder().decode(Fact.self, from: data)
    return fact
  }
}

public struct Fact: Decodable {
  let text: String
}

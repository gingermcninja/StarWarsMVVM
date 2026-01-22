//
//  PeopleViewModel.swift
//  StarWarsMVVM
//
//  Created by Paul McGrath on 1/22/26.
//

import SwiftUI
import Combine

@MainActor
final class PeopleViewModel: ObservableObject {
    
  @Published var people: [Person] = []
  @Published var selection: Person?
  @Published var nextPageURL: URL?
  @Published var isLoading = false
  @Published var errorMessage: String?

  func refresh() async {
    await load(reset: true)
  }

  func loadMoreIfNeeded(current person: Person?) async {
    guard let person = person else { return }
    guard let last = people.last, last == person, nextPageURL != nil else { return }
    await load(reset: false)
  }

  private func load(reset: Bool) async {
    if isLoading { return }
    isLoading = true
    defer { isLoading = false }
    do {
      let page = try await SWAPIClient.shared.peoplePage(from: reset ? nil : nextPageURL)
      if reset {
        people = page
      } else {
        people += page
      }
      errorMessage = nil
    } catch {
      errorMessage = error.localizedDescription
    }
  }
}

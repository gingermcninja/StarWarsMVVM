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
  @Published var isLoading = false
  @Published var errorMessage: String?

  func refresh() async {
    await load()
  }

  private func load() async {
    if isLoading { return }
    isLoading = true
    defer { isLoading = false }
    do {
      people = try await SWAPIClient.shared.peoplePage()
      errorMessage = nil
    } catch {
      errorMessage = error.localizedDescription
    }
  }
}

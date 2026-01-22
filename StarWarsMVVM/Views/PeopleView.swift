import SwiftUI
import Combine

struct PeopleView: View {
  @StateObject private var vm = PeopleViewModel()

  var body: some View {
    NavigationSplitView {
      List(vm.people, id: \.self, selection: $vm.selection) { person in
        VStack(alignment: .leading) {
          Text(person.name).font(.headline)
          HStack(spacing: 8) {
            if let gender = person.gender { Text(gender.capitalized) }
            if let birth = person.birthYear { Text(birth) }
          }.foregroundStyle(.secondary)
        }
      }
      .navigationTitle("People")
      .refreshable { await vm.refresh() }
      .overlay(alignment: .center) {
        if vm.isLoading && vm.people.isEmpty { ProgressView() }
      }
      .task { if vm.people.isEmpty { await vm.refresh() } }
    } detail: {
      if let person = vm.selection {
        PersonDetailView(person: person)
      } else {
        ContentUnavailableView("Select a person", systemImage: "person")
      }
    }
  }
}

#Preview { PeopleView() }

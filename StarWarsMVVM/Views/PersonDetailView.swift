import SwiftUI

struct PersonDetailView: View {
  let person: Person

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 12) {
        GroupBox { LabeledContent("Name", value: person.name) }
          
        if let gender = person.gender { GroupBox { LabeledContent("Gender", value: gender.capitalized) } }
        if let birth = person.birthYear { GroupBox { LabeledContent("Birth Year", value: birth) } }
        if let height = person.height { GroupBox { LabeledContent("Height", value: height) } }
        if let mass = person.mass { GroupBox { LabeledContent("Mass", value: mass) } }
        if let hair = person.hairColor { GroupBox { LabeledContent("Hair Color", value: hair.capitalized) } }
        if let skin = person.skinColor { GroupBox { LabeledContent("Skin Color", value: skin.capitalized) } }
        if let eye = person.eyeColor { GroupBox { LabeledContent("Eye Color", value: eye.capitalized) } }
      }
      .padding()
    }
    .navigationTitle(person.name)
  }
}

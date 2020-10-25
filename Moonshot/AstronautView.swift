//
//  AstronautView.swift
//  Moonshot
//
//  Created by Eric Liu on 10/23/20.
//

import SwiftUI

struct AstronautView: View {
  let astronaut: Astronaut
  let missions: [Mission]
  
  var body: some View {
    GeometryReader { geometry in
      ScrollView(.vertical) {
        VStack {
          Image(self.astronaut.id)
            .resizable()
            .scaledToFit()
            .frame(width: geometry.size.width)
          
          Text(self.astronaut.description)
            .padding()
            .layoutPriority(1)

          VStack(alignment: .leading) {
            Text("Participated Missions:")
              .padding()
              .font(.title2)
            ForEach(missions, id: \.id) { mission in
              Text("\(mission.displayName)")
            }
          }
        }
      }
    }
    .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
  }
  
  init(astronaut: Astronaut, missions: [Mission]) {
    self.astronaut = astronaut
    var selectedMissions = [Mission]()

    for mission in missions {
      for member in mission.crew {
        if member.name == astronaut.id {
          selectedMissions.append(mission)
        }
      }
    }
    
    self.missions = selectedMissions
  }
}

struct AstronautView_Previews: PreviewProvider {
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  static let missions: [Mission] = Bundle.main.decode("missions.json")

  static var previews: some View {
    AstronautView(astronaut: astronauts[0], missions: missions)
  }
}

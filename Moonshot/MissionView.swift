//
//  MissionView.swift
//  Moonshot
//
//  Created by Eric Liu on 10/23/20.
//

import SwiftUI

struct MissionView: View {
  struct CrewMember {
    let role: String
    let astronaut: Astronaut
  }

  let mission: Mission
  let astronauts: [CrewMember]
  
  var body: some View {
    GeometryReader { geometry in
      ScrollView(.vertical) {
        VStack {
          Image(self.mission.image)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: geometry.size.width * 0.7)
            .padding(.top)

          Text(self.mission.description)
            .padding()

          ForEach(self.astronauts, id: \.role) {
            crewMember in
            NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
              HStack {
                Image(crewMember.astronaut.id)
                  .resizable()
                  .scaledToFit()
                  .frame(width: 120, height: 80)
                  .clipShape(Circle())
                  .overlay(Circle()
                            .stroke(Color.white, lineWidth: 1))
                
                VStack(alignment: .leading) {
                  Text(crewMember.astronaut.name)
                    .font(.headline)
                  
                  Text(crewMember.role)
                    .foregroundColor(crewMember.role == "Commander" ? .blue : .secondary)
                }
                
                Spacer()
              }
              .padding(.horizontal)
            }
            .buttonStyle(PlainButtonStyle())
          }
          Spacer(minLength: 25)
        }
      }
    }
    .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
  }
  
  init(mission: Mission, astronauts: [Astronaut]) {
    self.mission = mission
    var matches = [CrewMember]()
    
    for member in mission.crew {
      if let match = astronauts.first(where: { $0.id == member.name }) {
        matches.append(CrewMember(role: member.role, astronaut: match))
      } else {
        fatalError("Mission\(member)")
      }
    }
    
    self.astronauts = matches
  }
}

struct MissionView_Previews: PreviewProvider {
  static let missions: [Mission] = Bundle.main.decode("missions.json")
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  
  static var previews: some View {
    Group {
      MissionView(mission: missions[1], astronauts: astronauts)
    }
      
  }
}

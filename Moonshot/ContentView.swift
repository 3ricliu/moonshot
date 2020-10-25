//
//  ContentView.swift
//  Moonshot
//
//  Created by Eric Liu on 10/21/20.
//

import SwiftUI


struct ContentView: View {
  let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  let missions: [Mission] = Bundle.main.decode("missions.json")
  @State private var showingAstronauts = false
  
  var body: some View {
    NavigationView {
      List(missions) { mission in
        NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts, missions: missions)) {
          Image(mission.image)
            .resizable()
            .scaledToFit()
            .frame(width: 44, height: 44)
          
          VStack(alignment: .leading) {
            Text(mission.displayName)
              .font(.headline)
            Text(self.getDetails(mission))
          }
        }
      }
      .navigationBarTitle("Moonshot")
      .navigationBarItems(trailing: Button("Details") {
        self.toggleAstronauts()
      })
    }
  }
  
  func toggleAstronauts() {
    print("hello")
    self.showingAstronauts.toggle()
  }
  
  func getDetails(_ mission: Mission) -> String {
    if showingAstronauts {
      return mission.crewNames
    } else {
      return mission.formattedLaunchDate
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

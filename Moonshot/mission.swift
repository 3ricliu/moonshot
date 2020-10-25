//
//  mission.swift
//  Moonshot
//
//  Created by Eric Liu on 10/22/20.
//

import Foundation

struct Mission: Codable, Identifiable {
  struct CrewRole: Codable {
    let name: String
    let role: String
  }
  
  let id: Int
  let launchDate: Date?
  let crew: [CrewRole]
  let description: String
  
  var displayName: String {
    "Apollo \(id)"
  }
  
  var image: String {
    "apollo\(id)"
  }
  
  var formattedLaunchDate: String {
    if let launchDate = launchDate {
      let formatter = DateFormatter()
      formatter.dateStyle = .long
      return formatter.string(from: launchDate)
    } else {
      return "N/A"
    }
  }
  
  var crewNames: String {
    var names: [String] = []

    for member in crew {
      names.append(member.name.capitalized)
    }
    
    return names.joined(separator: ", ")
  }
}

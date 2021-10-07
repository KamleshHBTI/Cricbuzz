//
//  MovieCategory.swift
//  MovieCategory
//
//  Created by Kamlesh on 28/09/21.
//

import Foundation

enum CategoryType:String, CaseIterable{
  case Year
  case Genre
  case Directors
  case Actors
  
static func getType(_ index: Int) -> String{
    let types: [String] = CategoryType.allCases.map { $0.rawValue }
    return types[index]
  }
    
}

enum RatingType: String{
  case Internet = "Internet Movie Database"
  case Rotten = "Rotten Tomatoes"
  case Metacritic = "Metacritic"
}


enum CellType: String{
  case defaultCell
  case MovieCell
}

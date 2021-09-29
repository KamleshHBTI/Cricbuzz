//
//  Movie.swift
//  Movie
//
//  Created by Kamlesh on 28/09/21.
//

import Foundation
struct Movies:Codable{
  let movies: [Movie]
}

// MARK: - Movie
struct Movie: Codable {
 
  
    let title, year, rated, released: String?
    let runtime, genre, director, writer: String?
    let actors, plot, language, country: String?
    let awards: String?
    let poster: String?
    let ratings: [Rating]
    let metascore, imdbRating, imdbVotes, imdbID: String?
    let type, dvd, boxOffice, production: String?
    let website, response: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
  
  func getValuesForType(_ type: CategoryType) -> [String]?{
    switch type {
    case .Year:
      return year?.split(separator: "-").map { String($0.trimmingCharacters(in: .whitespaces))}
    case .Genre:
      return genre?.split(separator: ",").map { String($0.trimmingCharacters(in: .whitespaces)) }
    case .Directors:
      return director?.split(separator: ",").map { String($0.trimmingCharacters(in: .whitespaces)) }
    case .Actors:
      return actors?.split(separator: ",").map { String($0.trimmingCharacters(in: .whitespaces)) }
    }
  }
  
  func getMoviesForType(_ type: CategoryType, _ subCategory: String) -> Bool{
    switch type {
    case .Year:
      return year?.contains(subCategory) ?? false
    case .Genre:
      return genre?.contains(subCategory) ?? false
    case .Directors:
      return director?.contains(subCategory) ?? false
    case .Actors:
      return actors?.contains(subCategory) ?? false
    }
  }
  
  func getMovieForSearch(_ searchText: String) -> Bool{
   return ((genre?.contains(searchText) ?? false) || (actors?.contains(searchText) ?? false) || (director?.contains(searchText) ?? false) || (title?.contains(searchText) ?? false))
    
  }
  
  
}

// MARK: - Rating
struct Rating: Codable {
    let source, value: String

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

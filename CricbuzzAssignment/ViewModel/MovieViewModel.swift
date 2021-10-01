//
//  MovieViewModel.swift
//  MovieViewModel
//
//  Created by Kamlesh on 28/09/21.
//

import Foundation
import UIKit
class MovieViewModel{
  
  var movies = [Movie]()
  var searchMovies = [Movie]()
  var categoryArray = [String]()
  var originalMovieData = [Movie]()
  var categortyType: CategoryType = .Genre
  var isFilteredMovies = false
  
  init(){
    getMovies()
  }
  
  func getMovies() {
    let decoder = JSONDecoder()
    if let file = Bundle.main.url(forResource: "movies", withExtension: "json") {
      if let data = try? Data(contentsOf: file){
        let movies = try! decoder.decode([Movie].self, from: data)
        self.movies = movies
        self.originalMovieData = movies
      }
    }
  }
  
  func registerAndSetupCell(_ tableView: UITableView,_ indexPath: IndexPath) -> UITableViewCell{
    let identifier = isFilteredMovies ? CellType.MovieCell.rawValue: CellType.defaultCell.rawValue
    if isFilteredMovies{
      let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! MovieCell
      cell.setUpCell(movies[indexPath.row])
      return cell
    }else {
      let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
      cell.textLabel?.text = CategoryType.getType(indexPath.row)
      return cell
    }
  }
  
  func filterMoviesByCategory(_ type:CategoryType) {
    categortyType = type
    let filteredData: [String] = movies.reduce([String]()) { partialResult, movie in
      partialResult + (movie.getValuesForType(type) ?? [])
    }
    categoryArray = Array(Set(filteredData))
  }
  
  func searchMovieByText(_ searchText:String) -> [Movie]{
    searchMovies = originalMovieData.filter{ $0.getMovieForSearch(searchText.lowercased())}
    return searchMovies
  }
  
  func getMoviesOfSubCategory(_ type: CategoryType, _ subCategory: String) -> [Movie]{
    return movies.filter({$0.getMoviesForType(type, subCategory)})
  }
  
  
}

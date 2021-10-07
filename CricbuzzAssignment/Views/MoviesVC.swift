//
//  ViewController.swift
//  CricbuzzAssignment
//
//  Created by Kamlesh on 28/09/21.
//

import UIKit

class MoviesVC: UIViewController {
  
  @IBOutlet weak var movieTblView: UITableView!
  
  var viewModel = MovieViewModel()
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    searchBar.delegate = self
    self.searchBar.endEditing(true)
  }
  
  private func configureUI() {
    movieTblView.keyboardDismissMode = .onDrag
    movieTblView.allowsSelection = true
    searchBar.isHidden = viewModel.isFilteredMovies
  }
}

extension MoviesVC : UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.isFilteredMovies ? viewModel.movies.count : CategoryType.allCases.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = viewModel.registerAndSetupCell(tableView, indexPath)
    return cell
  }
  
}

extension MoviesVC: UITableViewDelegate{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if viewModel.isFilteredMovies{
      let deatilsVC = MovieDetailVC.instantiateFromStoryboard()
      deatilsVC.movie = viewModel.movies[indexPath.row]
      self.navigationController?.pushViewController(deatilsVC, animated: true)
    }else {
      let movieCategoryVC = MovieCategoryVC.instantiateFromStoryboard()
      movieCategoryVC.viewModel = viewModel
      viewModel.filterMoviesByCategory(CategoryType.allCases[indexPath.row])
      self.navigationController?.pushViewController(movieCategoryVC, animated: true)
    }
    
  }
}

extension MoviesVC: UISearchBarDelegate{
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.movies = searchText.count > 0 ? viewModel.searchMovieByText(searchText.replacingOccurrences(of: " ", with: "")) : viewModel.originalMovieData
    viewModel.isFilteredMovies = searchText.count > 0
    movieTblView.reloadData()
    
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    viewModel.isFilteredMovies = false
    viewModel.movies = viewModel.originalMovieData
    movieTblView.reloadData()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
  
}


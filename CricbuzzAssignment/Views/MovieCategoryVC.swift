//
//  MovieCategoryVC.swift
//  MovieCategoryVC
//
//  Created by Kamlesh on 28/09/21.
//

import Foundation
import UIKit
class MovieCategoryVC: UIViewController{
  
  var tableView: UITableView = {
    let tblView = UITableView()
    return tblView
  }()
  
  weak var viewModel: MovieViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    tableView.reloadData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.isFilteredMovies = false
    viewModel.movies = viewModel.originalMovieData
  }
  
  private func  configureUI(){
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
      tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
      tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8),
      tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -8)
    ])
  }
  
}

extension MovieCategoryVC: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return  viewModel.categoryArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
    cell.textLabel?.text = viewModel.categoryArray[indexPath.row]
    return cell
  }
  
}

extension MovieCategoryVC: UITableViewDelegate{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let moviesVC = MoviesVC.instantiateFromStoryboard()
    moviesVC.viewModel = viewModel
    moviesVC.viewModel.isFilteredMovies = true
    categoriesMovies(viewModel.categoryArray[indexPath.row])
    self.navigationController?.pushViewController(moviesVC, animated: true)
  }
  
  private func categoriesMovies(_ subCategory: String){
    viewModel.movies = viewModel.getMoviesOfSubCategory(viewModel.categortyType, subCategory)
  }
}

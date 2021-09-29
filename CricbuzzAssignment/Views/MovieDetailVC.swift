//
//  MovieDetailVC.swift
//  MovieDetailVC
//
//  Created by Kamlesh on 29/09/21.
//

import Foundation
import UIKit

class MovieDetailVC: UIViewController{
  
  let movieDetail =  MovieDetail()
  var movie:Movie!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    movieDetail.frame = self.view.frame
    self.view = movieDetail
    movieDetail.configure(with: movie)
  }
  
  private func configureUI(){
    configureRatingView()
  }
  
  private func configureRatingView(){
    
  }
  
}

//
//  MovieDetail.swift
//  MovieDetail
//
//  Created by Kamlesh on 29/09/21.
//

import Foundation
import UIKit

class MovieDetail: UIView{
  
  private var title: UILabel!
  private var releasedDate: UILabel!
  private var genre: UILabel!
  private var rating: UILabel!
  private var plot: UILabel!
  private var poster: UIImageView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI(){
    setupUI()
    self.backgroundColor = .white
  }
  
  public func configure(with movie: Movie) {
    title.text = movie.title
    genre.text = movie.genre
    releasedDate.text = movie.released
    rating.text = movie.imdbRating
    plot.text = movie.plot
    if let stringUrl =  movie.poster, let url = URL(string: stringUrl) {
      downloadImage(from: url)
    }
  }
  
  func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
  }

  func downloadImage(from url: URL) {
      print("Download Started")
      getData(from: url) { data, response, error in
          guard let data = data, error == nil else { return }
          print(response?.suggestedFilename ?? url.lastPathComponent)
          print("Download Finished")
          // always update the UI from the main thread
          DispatchQueue.main.async() { [weak self] in
              self?.poster.image = UIImage(data: data)
          }
      }
  }
  
  private func setupUI() {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.spacing = 8
    stackView.alignment = .leading
    stackView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
      stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
      stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
      stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
    ])
    
    poster = UIImageView()
    stackView.addArrangedSubview(poster)
    NSLayoutConstraint.activate([
      poster.widthAnchor.constraint(equalToConstant: 60),
      poster.heightAnchor.constraint(equalToConstant: 100)
    ])
    
    title = UILabel()
    title.font = .boldSystemFont(ofSize: 14)
    title.numberOfLines = 0
    title.lineBreakMode = .byWordWrapping
    
    releasedDate = UILabel()
    releasedDate.font = .systemFont(ofSize: 14)
    releasedDate.numberOfLines = 3
    releasedDate.lineBreakMode = .byTruncatingTail
    
    genre = UILabel()
    genre.font = .systemFont(ofSize: 14)
    genre.numberOfLines = 0
    genre.lineBreakMode = .byTruncatingTail
    
    plot = UILabel()
    plot.font = .systemFont(ofSize: 14)
    plot.numberOfLines = 0
    plot.lineBreakMode = .byTruncatingTail
    
    rating = UILabel()
    rating.font = .systemFont(ofSize: 14)
    rating.numberOfLines = 3
    rating.lineBreakMode = .byTruncatingTail
    
    
    let textStackView = UIStackView()
    textStackView.axis = .vertical
    textStackView.distribution = .equalSpacing
    textStackView.alignment = .leading
    textStackView.spacing = 4
    textStackView.addArrangedSubview(title)
    textStackView.addArrangedSubview(genre)
    textStackView.addArrangedSubview(releasedDate)
    textStackView.addArrangedSubview(rating)
    textStackView.addArrangedSubview(plot)
    stackView.addArrangedSubview(textStackView)
  }
}

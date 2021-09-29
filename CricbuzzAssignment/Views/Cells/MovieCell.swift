//
//  MovieCell.swift
//  MovieCell
//
//  Created by Kamlesh on 28/09/21.
//

import Foundation
import UIKit
import Combine

class MovieCell: UITableViewCell{
  
  private var title: UILabel!
  private var language: UILabel!
  private var year: UILabel!
  private var poster: UIImageView!
  private var cancellable: AnyCancellable?
  private var animator: UIViewPropertyAnimator?
  
  
  func setUpCell<T>(_ value: T?){
    setupUI()
    if let movie = value as? Movie {
      configure(with: movie)
    }else {
      self.textLabel?.text = value as? String
    }
  }
  
  override public func prepareForReuse() {
    super.prepareForReuse()
    poster.image = nil
    poster.alpha = 0.0
    language.text = nil
    year.text = nil
    title.text = nil
    animator?.stopAnimation(true)
    cancellable?.cancel()
  }
  
  public func configure(with movie: Movie) {
    title.text = movie.title
    language.text = movie.language
    year.text = movie.year
    cancellable = loadImage(for: movie).sink { [unowned self] image in self.showImage(image: image) }
  }
  
  private func showImage(image: UIImage?) {
    poster.alpha = 0.0
    animator?.stopAnimation(false)
    poster.image = image
    animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
      self.poster.alpha = 1.0
    })
  }
  
  private func loadImage(for movie: Movie) -> AnyPublisher<UIImage?, Never> {
    return Just(movie.poster)
      .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
        let url = URL(string: movie.poster ?? "")!
        return ImageLoader.shared.loadImage(from: url)
      })
      .eraseToAnyPublisher()
  }
  
  private func setupUI() {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.spacing = 8
    stackView.alignment = .leading
    stackView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
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
    
    language = UILabel()
    language.font = .systemFont(ofSize: 14)
    language.numberOfLines = 3
    language.lineBreakMode = .byTruncatingTail
    
    year = UILabel()
    year.font = .systemFont(ofSize: 14)
    year.numberOfLines = 3
    year.lineBreakMode = .byTruncatingTail
    
    let textStackView = UIStackView()
    textStackView.axis = .vertical
    textStackView.distribution = .equalSpacing
    textStackView.alignment = .leading
    textStackView.spacing = 4
    textStackView.addArrangedSubview(title)
    textStackView.addArrangedSubview(language)
    textStackView.addArrangedSubview(year)
    stackView.addArrangedSubview(textStackView)
  }
}

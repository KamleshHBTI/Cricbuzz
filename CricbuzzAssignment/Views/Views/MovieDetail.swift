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
  private var starView: StarsView!
  private var pickerview: UIPickerView!
  private var sourceRating:[Rating]?

  private var stackView: UIStackView!

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
    starView.rating = Double(String(movie.imdbRating ?? "")) ?? 0
    sourceRating = movie.ratings
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
    getData(from: url) { data, response, error in
      guard let data = data, error == nil else { return }
      // always update the UI from the main thread
      DispatchQueue.main.async() { [weak self] in
        self?.poster.image = UIImage(data: data)
      }
    }
  }
  
  
  private func pickerViewSetup(){
    pickerview = UIPickerView()
    pickerview.dataSource = self
    pickerview.delegate = self
    NSLayoutConstraint.activate([
      pickerview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
      pickerview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
      pickerview.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 100),
      pickerview.heightAnchor.constraint(equalToConstant: self.frame.height / 3)

    ])
    self.addSubview(pickerview)
  }
  
  private func stackViewSetup(){
    stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.spacing = 10
    stackView.alignment = .leading
    stackView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
      stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
      stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
      stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
    ])
  }
  
  private func posterSetup(){
    poster = UIImageView()
    stackView.addArrangedSubview(poster)
    NSLayoutConstraint.activate([
      poster.widthAnchor.constraint(equalToConstant: 60),
      poster.heightAnchor.constraint(equalToConstant: 100)
    ])
  }
  
  private func starViewSetup(){
    starView = StarsView(frame: CGRect(x: self.frame.origin.x , y: rating.frame.origin.y + 10, width: 100, height: 30))
    starView.tintColor = .blue
  }
  
  private func setupUI() {
 
    stackViewSetup()
    //pickerViewSetup()
    posterSetup()
    allLabelSetup()
    
    starViewSetup()
    
    let textStackView = UIStackView()
    textStackView.axis = .vertical
    textStackView.distribution = .fill
    textStackView.alignment = .leading
    textStackView.spacing = 4
    textStackView.addArrangedSubview(title)
    textStackView.addArrangedSubview(genre)
    textStackView.addArrangedSubview(releasedDate)
    textStackView.addArrangedSubview(rating)
    textStackView.addArrangedSubview(plot)
    textStackView.addArrangedSubview(starView)
    stackView.addArrangedSubview(textStackView)
  }
  
  private func allLabelSetup(){
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
    plot.font = .systemFont(ofSize: 12)
    plot.numberOfLines = 10
    plot.lineBreakMode = .byTruncatingTail
    
    rating = UILabel()
    rating.numberOfLines = 3
    rating.font = .boldSystemFont(ofSize: 12)
    rating.lineBreakMode = .byTruncatingTail
  }
}
extension MovieDetail: UIPickerViewDelegate{
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
  }
}

extension MovieDetail: UIPickerViewDataSource{
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return sourceRating?.count ?? 0
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return (sourceRating?[row].source ?? "")   + "Ratings -> " + (sourceRating?[row].value ?? "")
  }
  
}

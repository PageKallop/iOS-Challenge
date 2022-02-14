//
//  genreButtons.swift
//  Movie Challenge
//
//  Created by Page Kallop on 2/12/22.
//

import Foundation
import UIKit

class GenreButtons: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    public var allMovies : [GetMoviesQueryQuery.Data.Movie] = []
    var resetArray : [GetMoviesQueryQuery.Data.Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        view.addSubview(stackView)
        stackConstraints()
        collectionLayout()
        collectionConstraiants()
        createNav()
    }
    //MARK: - Creats NavBar/Items
    func createNav() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 40, width: view.frame.size.width, height: 50))
        view.addSubview(navBar)
        navBar.barTintColor = UIColor.black
        let closeItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(goBack))
        let navItem = UINavigationItem(title: "Movie By Genre")
        navBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navItem.leftBarButtonItem = closeItem
        closeItem.tintColor = .white
        navBar.setItems([navItem], animated: false)
        
    }
    
    @objc func goBack(){
        dismiss(animated: true, completion: nil)
    }
    //MARK: - CollectionView methods
    func collectionLayout(){
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CardItem.self, forCellWithReuseIdentifier: CardItem.identifier)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return allMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardItem.identifier, for: indexPath) as! CardItem
        
        let movieSorted = allMovies[indexPath.row]
        cell.titleLabel.isHidden = true
        cell.image.load(urlString: movieSorted.posterPath ?? "https://image.tmdb.org/t/p/w300_and_h450_bestv2//uFyivAeeG3h8Gt5a99ACRC44vZL.jpg")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedMovie = allMovies[indexPath.row]
        let moviePoster = MoviePosterView()
        moviePoster.modalPresentationStyle = .fullScreen
        present(moviePoster, animated: true, completion: nil)
        
        moviePoster.titleLabel.text = selectedMovie.title
        moviePoster.overview.text = selectedMovie.overview
        moviePoster.imageView.load(urlString: selectedMovie.posterPath ?? "https://image.tmdb.org/t/p/w300_and_h450_bestv2//uFyivAeeG3h8Gt5a99ACRC44vZL.jpg")
        moviePoster.cast.text = "CAST:\n\n\(selectedMovie.cast.compactMap({$0.name}).joined(separator: "\n"))"
        moviePoster.director.text = "DIRECTOR:\n\n\(selectedMovie.director.name)"
        moviePoster.genre.text = "GENRE:\n\n\(selectedMovie.genres.joined(separator: "\n"))"
        if selectedMovie.voteAverage <= 7.0 {
            moviePoster.voteAverage.text = "⭐️⭐️⭐️⭐️⭐️"
        } else if selectedMovie.voteAverage <= 5.0 {
            moviePoster.voteAverage.text = "⭐️⭐️⭐️"
        } else {
            moviePoster.voteAverage.text = "⭐️⭐️"
        }
    }
    
    //MARK: - UIButton methods
    @objc func comedySort() {
        
        allMovies = resetArray
        let filteredComedyArray = allMovies.compactMap({$0})
        let searchString = "Comedy"
        allMovies = filteredComedyArray.filter({ $0.genres.contains(searchString)})
        self.collectionView.reloadData()
    }
    @objc func dramaSort() {
        
        allMovies = resetArray
        let filteredDramaArray = allMovies.compactMap({$0})
        let searchString = "Drama"
        allMovies = filteredDramaArray.filter({ $0.genres.contains(searchString)})
        self.collectionView.reloadData()
        
    }
    @objc func horrorSort() {
        
        allMovies = resetArray
        let filteredHorrorArray = allMovies.compactMap({$0})
        let searchString = "Horror"
        allMovies = filteredHorrorArray.filter({ $0.genres.contains(searchString)})
        self.collectionView.reloadData()
        
    }
    @objc func ActionSort() {
        
        allMovies = resetArray
        let filteredActionArray = allMovies.compactMap({$0})
        let searchString = "Action"
        allMovies = filteredActionArray.filter({ $0.genres.contains(searchString)})
        self.collectionView.reloadData()
        
    }
    //MARK: - UIElements
    private enum LayoutConstant {
        static let spacing: CGFloat = 16.0
        static let itemHeight: CGFloat = 150
    }
    
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    let comedyGenre: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("comedy", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(comedySort), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let dramaByGenre: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("drama", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(dramaSort), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let horrorByGenre: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("horror", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(horrorSort), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let actionByGenre: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("action", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(ActionSort), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.distribution = .fillEqually
        return stackView
    }()
    
}
//MARK: - CollectionViewCell layout
extension GenreButtons: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = itemWidth(for: view.frame.width, spacing: LayoutConstant.spacing)
        
        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 4
        
        let totalSpacing: CGFloat = 1 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return floor(finalWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: LayoutConstant.spacing, left: LayoutConstant.spacing, bottom: LayoutConstant.spacing, right: LayoutConstant.spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
}
//MARK: - Constraints
extension GenreButtons {
    
    func collectionConstraiants() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func stackConstraints() {
        
        stackView.addArrangedSubview(comedyGenre)
        stackView.addArrangedSubview(dramaByGenre)
        stackView.addArrangedSubview(horrorByGenre)
        stackView.addArrangedSubview(actionByGenre)
        stackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
    
}

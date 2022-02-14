//
//  AllMovieView.swift
//  Movie Challenge
//
//  Created by Page Kallop on 2/11/22.
//

import Foundation
import UIKit

class AllMovieView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public var allMovies : [GetMoviesQueryQuery.Data.Movie] = []
    var resetArray : [GetMoviesQueryQuery.Data.Movie] = []
    
    lazy var searchBar : UISearchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()
        view.backgroundColor = .black
        view.addSubview(searchBar)
        searchBar.sizeToFit()
        setSearchBar()
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AllMovieCell.self, forCellReuseIdentifier: "cell")
        tableViewConstraints()
        createNav()
        
    }
    //MARK: - Creats NavBar/Items
    func createNav() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 30, width: view.frame.size.width, height: 50))
        view.addSubview(navBar)
        navBar.barTintColor = UIColor.black
        navBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let closeItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(goBack))
        let navItem = UINavigationItem(title: "All Movies")
        navItem.leftBarButtonItem = closeItem
        closeItem.tintColor = .white
        navBar.setItems([navItem], animated: false)
        
    }
    @objc func goBack(){
        dismiss(animated: true, completion: nil)
    }
    //MARK: - tableView
    let tableView : UITableView = {
        
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - tableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allMovies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AllMovieCell
        let movieList = allMovies[indexPath.row]
        
        cell.titleLabel.text = movieList.title
        if movieList.voteAverage <= 7.0 {
            cell.ratingLabel.text = "⭐️⭐️⭐️⭐️⭐️"
        } else if movieList.voteAverage <= 5.0 {
            cell.ratingLabel.text = "⭐️⭐️⭐️"
        } else {
            cell.ratingLabel.text = "⭐️⭐️"
        }
        cell.image.load(urlString: movieList.posterPath ?? "https://image.tmdb.org/t/p/w300_and_h450_bestv2//uFyivAeeG3h8Gt5a99ACRC44vZL.jpg")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        if selectedMovie.voteAverage  <= 7.0 {
            moviePoster.voteAverage.text = "⭐️⭐️⭐️⭐️⭐️"
        } else if selectedMovie.voteAverage <= 5.0 {
            moviePoster.voteAverage.text = "⭐️⭐️⭐️"
        } else {
            moviePoster.voteAverage.text = "⭐️⭐️"
        }
    }
    
}
//MARK: - SearchBar setup
extension AllMovieView: UISearchBarDelegate {
    
    func setSearchBar(){
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = " Search..."
        searchBar.isTranslucent = false
        searchBar.searchTextField.textColor = .white
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
        searchBar.barTintColor = .white
        navigationItem.titleView = searchBar
        
        
        searchBar.frame = CGRect(x: 0, y: 60, width: view.frame.width, height: 75)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        let filteredArray = allMovies.compactMap({$0})
        if searchText.isEmpty == false {
            allMovies = filteredArray.filter({$0.title.contains(searchText) || $0.genres[0].contains(searchText)})
            tableView.reloadData()
        } else if searchText.isEmpty == true {
            allMovies = resetArray
            
            tableView.reloadData()
        }
        
    }
}
//MARK: - Constraints
extension AllMovieView {
    
    
    func tableViewConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rowHeight = 200
        
    }
}


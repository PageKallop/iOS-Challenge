import UIKit
import Apollo
import XCTest

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    public var allMovies : [GetMoviesQueryQuery.Data.Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let query = GetMoviesQueryQuery()
        Network.shared.apollo.fetch(query: query) { [self] result in
            switch result {
            case .success(let graphQLResult):
                if let movieList = graphQLResult.data?.movies?.compactMap({$0}) {
                    self.allMovies = movieList
                    self.collectionView.reloadData()
                    
                }
            case .failure(let error):
                print("Error getting movies: \(error.localizedDescription)")
            }
        }
        
        view.addSubview(collectionView)
        view.addSubview(screenLabel)
        view.addSubview(stackView)
        stackConstraints()
        collectionLayout()
        collectionConstraiants()
        
    }
    
    //MARK: - UIButton functionality
    @objc func toAllMovie(){
        let allMovieView = AllMovieView()
        allMovieView.allMovies = allMovies.self
        allMovieView.resetArray = allMovies.self
        allMovieView.modalPresentationStyle = .fullScreen
        present(allMovieView, animated: true, completion: nil)
    }
    
    @objc func toGenres(){
        let toGenres = GenreButtons()
        toGenres.allMovies = allMovies.self
        toGenres.resetArray = allMovies.self
        toGenres.modalPresentationStyle = .fullScreen
        present(toGenres, animated: true, completion: nil)
    }
    
    //MARK: - CollectionView methods
    func collectionLayout(){
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CardItem.self, forCellWithReuseIdentifier: CardItem.identifier)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sortedByRating = self.allMovies.sorted {
            $0.voteAverage < $1.voteAverage
            
        }
        
        return sortedByRating.prefix(5).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardItem.identifier, for: indexPath) as! CardItem
        
        let sortedByRating = self.allMovies.sorted {
            $0.voteAverage < $1.voteAverage
        }
        let movieSorted = sortedByRating[indexPath.row]
        cell.titleLabel.text = movieSorted.title
        cell.image.load(urlString: movieSorted.posterPath ?? "https://image.tmdb.org/t/p/w300_and_h450_bestv2//uFyivAeeG3h8Gt5a99ACRC44vZL.jpg")
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sortedByRating = self.allMovies.sorted {
            $0.voteAverage < $1.voteAverage
        }
        let selectedMovie = sortedByRating[indexPath.row]
        let moviePoster = MoviePosterView()
        moviePoster.modalPresentationStyle = .fullScreen
        present(moviePoster, animated: true, completion: nil)
        
        moviePoster.titleLabel.text = selectedMovie.title
        moviePoster.overview.text = "OVERVIEW:\n\n\(selectedMovie.overview)"
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
    //MARK: - UIElements
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 16.0
        static let itemHeight: CGFloat = 400.0
    }
    let screenLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "Top Rated"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        
        stackView.backgroundColor = .white
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let toAllMovies: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("See All Movies", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(toAllMovie), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let moviesByGenre: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("See Movies By Genre", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(toGenres), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
}
//MARK: - Constraints
extension ViewController {
    
    func collectionConstraiants() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        screenLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        screenLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        screenLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        screenLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
    }
    
    func stackConstraints() {
        
        stackView.addArrangedSubview(toAllMovies)
        stackView.addArrangedSubview(moviesByGenre)
        stackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
}

//MARK: - CollectionViewCell layout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = itemWidth(for: view.frame.width, spacing: LayoutConstant.spacing)
        
        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 1.5
        
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
//MARK: - Fetch URL Image
extension UIImageView  {
    
    func load(urlString: String){
        guard let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        
                    }
                }
            }
        }
    }
    
}

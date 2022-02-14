//
//  MoviePosterView.swift
//  Movie Challenge
//
//  Created by Page Kallop on 2/11/22.
//

import Foundation
import UIKit

class MoviePosterView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(stackView)
        view.addSubview(imageView)
        stackViewConstraints()
        imageConstraints()
        createNav()
        
    }
    //MARK: - Creats NavBar/Items
    func createNav() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 25, width: view.frame.size.width, height: 35))
        view.addSubview(navBar)
        navBar.barTintColor = UIColor.clear
        let closeItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(goBack))
        let navItem = UINavigationItem(title: "")
        navItem.leftBarButtonItem = closeItem
        closeItem.tintColor = .white
        navBar.setItems([navItem], animated: false)
        
    }
    
    @objc func goBack(){
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - UIElements
    let imageView : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var titleLabel : UILabel = {
        let title = UILabel()
        title.backgroundColor = .clear
        title.textColor = .white
        title.textAlignment = .center
        title.font = .boldSystemFont(ofSize: 20)
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    var voteAverage : UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.backgroundColor = .clear
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    var overview : UILabel = {
        let title = UILabel()
        title.backgroundColor = .clear
        title.textColor = .white
        title.font = UIFont(name: "Arial", size: 13)
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    var cast : UILabel = {
        let title = UILabel()
        title.backgroundColor = .clear
        title.textColor = .white
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
        title.font = UIFont(name: "Arial", size: 13)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    var director : UILabel = {
        let title = UILabel()
        title.backgroundColor = .clear
        title.textColor = .white
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
        title.font = UIFont(name: "Arial", size: 13)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    var genre : UILabel = {
        let title = UILabel()
        title.backgroundColor = .clear
        title.textColor = .white
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
        title.font = UIFont(name: "Arial", size: 10)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
}
//MARK: - Constraints
extension MoviePosterView {
    
    func imageConstraints(){
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -550).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    
    func stackViewConstraints(){
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(voteAverage)
        stackView.addArrangedSubview(overview)
        stackView.addArrangedSubview(cast)
        stackView.addArrangedSubview(director)
        stackView.addArrangedSubview(genre)
        
        stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        
    }
}

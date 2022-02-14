//
//  AllMoviesCell.swift
//  Movie Challenge
//
//  Created by Page Kallop on 2/12/22.
//

import Foundation
import UIKit

class AllMovieCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .black
        addSubview(image)
        addSubview(stackView)
        imageLabelConstraints()
        stackViewConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIElemnts
    var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let image : UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
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
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
        title.font = .boldSystemFont(ofSize: 15)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    var ratingLabel : UILabel = {
        let title = UILabel()
        title.backgroundColor = .clear
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
}
//MARK: - Constraints
extension AllMovieCell {
    
    func imageLabelConstraints() {
        image.topAnchor.constraint(equalTo: topAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -225).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
    
    func stackViewConstraint() {
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(ratingLabel)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 150).isActive = true
    }
    
}

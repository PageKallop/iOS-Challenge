//
//  CardSlider.swift
//  Movie Challenge
//
//  Created by Page Kallop on 2/10/22.
//

import UIKit


class CardItem: UICollectionViewCell {
    
    static let identifier = "CardItemCell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        imageConstraint()
        titleLabelConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIElements
    let image : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var titleLabel : UILabel = {
        let title = UILabel()
        title.backgroundColor = .black
        title.textColor = .white
        title.textAlignment = .center
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
        title.font = .boldSystemFont(ofSize: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
}

//MARK: - Constraints
extension CardItem {
    
    func imageConstraint(){
        
        image.topAnchor.constraint(equalTo: topAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50).isActive = true
        image.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
    }
    func titleLabelConstraint(){
        
        titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
    }
}

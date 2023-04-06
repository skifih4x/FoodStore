//
//  TthreeCell.swift
//  FoodStore
//
//  Created by Артем Орлов on 04.04.2023.
//

import UIKit

class DishCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "DishCell"
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with recipe: RecipeResult) {
        titleLabel.text = recipe.title
        priceLabel.text = "от 300"
        
        guard let imageUrl = URL(string: recipe.image) else { return }
        loadImage(from: imageUrl)
    }
    
    // MARK: - Private Methods
    
    private func loadImage(from url: URL) {
        ImageCache.shared.getImage(for: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
    
    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 13
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        titleLabel.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        priceLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        priceLabel.textColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.0)
        priceLabel.textAlignment = .center
        priceLabel.layer.cornerRadius = 6
        priceLabel.layer.borderColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.0).cgColor
        priceLabel.layer.borderWidth = 0.5
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            imageView.widthAnchor.constraint(equalToConstant: 132),
            imageView.heightAnchor.constraint(equalToConstant: 132),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            priceLabel.heightAnchor.constraint(equalToConstant: 32),
            priceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 87)
        ])
    }
}

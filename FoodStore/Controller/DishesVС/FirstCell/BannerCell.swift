//
//  BannerCell.swift
//  FoodStore
//
//  Created by Артем Орлов on 04.04.2023.
//

import UIKit

class BannerCell: UICollectionViewCell {
    static let reuseIdentifier = "BannerCell"
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with info: Any?) {
        guard let image = info as? UIImage else {
            return
        }
        imageView.image = image
    }

    // MARK: - Private Methods
    
    private func setupViews() {
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

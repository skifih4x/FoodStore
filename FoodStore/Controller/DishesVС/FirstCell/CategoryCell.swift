//
//  CategoryCell.swift
//  FoodStore
//
//  Created by Артем Орлов on 04.04.2023.
//


import UIKit

class CategoryCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let reuseIdentifier = "CategoryCell"
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00)
                titleLabel.textColor = .white
            } else {
                contentView.backgroundColor = .clear
                titleLabel.textColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00)
            }
        }
    }
    
    func configure(_ string: String) {
        titleLabel.text = string
    }
    
    // MARK: - Private Methods
    
    private func setupView () {
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00).cgColor
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

//
//  CategoryCell.swift
//  FoodStore
//
//  Created by Артем Орлов on 04.04.2023.
//


import UIKit

class CategoryCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "CategoryCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setSelection(_ isSelected: Bool) {
        if isSelected {
            backgroundColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00)
            titleLabel.textColor = .white
        } else {
            backgroundColor = .clear
            titleLabel.textColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00)
        }
    }
    
    func configure(_ string: String) {
        titleLabel.text = string
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        addSubview(titleLabel)
        backgroundColor = .clear
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00).cgColor
        layer.cornerRadius = 15
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

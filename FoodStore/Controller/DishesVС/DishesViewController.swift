//
//  DishesViewController.swift
//  FoodStore
//
//  Created by Артем Орлов on 03.04.2023.
//

import UIKit

class DishesViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: RecipeListPresenterProtocol!
    
    lazy var locationLabel: UILabel = {
        var label = UILabel()
        label.text = "Москва ∨"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.reuseIdentifier)
        collection.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        collection.register(DishCell.self, forCellWithReuseIdentifier: DishCell.reuseIdentifier)
        collection.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.0)
        collection.showsVerticalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    // View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchRecipes()
        setLayout()
    }
    
    // MARK: - Private Methods
    
    private func setLayout() {
        view.addSubview(locationLabel)
        view.addSubview(collectionView)
        view.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.0)
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 22),
            locationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 27),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

    // MARK: - UICollectionViewDelegate

extension DishesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let category = presenter.categoryArray(row: indexPath.row)
            let indexes = presenter.indexesOfRecipes(forCategory: category)
            
            if let firstIndex = indexes.first {
                collectionView.scrollToItem(at: IndexPath(item: firstIndex, section: 2), at: .top, animated: true)
            }
        }
    }
}

    // MARK: - UIScrollViewDelegate

extension DishesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard collectionView.collectionViewLayout is UICollectionViewFlowLayout else { return }
        
        let sectionHeaderHeight = CGFloat(50)
        if scrollView.contentOffset.y + scrollView.safeAreaInsets.top >= sectionHeaderHeight {
            collectionView.contentInset = UIEdgeInsets(top: sectionHeaderHeight, left: 0, bottom: 0, right: 0)
            collectionView.contentOffset = CGPoint(x: 0, y: -sectionHeaderHeight)
        } else {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

    // MARK: - UICollectionViewDataSource

extension DishesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        case 1:
            return presenter.numberOfCategories()
        case 2:
            return presenter.numberOfDishes()
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.reuseIdentifier, for: indexPath) as! BannerCell
            let image = UIImage(named: "bannerFirst")
            cell.configure(with: image)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as! CategoryCell
            let category = presenter.categoryArray(row: indexPath.item)
            cell.configure(category)
            cell.tag = indexPath.item
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCell.reuseIdentifier, for: indexPath) as! DishCell
            if let presenter = presenter as? RecipeListPresenter {
                let dish = presenter.recipes[indexPath.item]
                cell.configure(with: dish)
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

    // MARK: - RecipeListViewProtocol

extension DishesViewController: RecipeListViewProtocol {
    func updateUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

    // MARK: - Composition layout

extension DishesViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return self.createBannerSection()
            case 1:
                return self.createCategorySection()
            case 2:
                return self.createDishSection()
            default:
                return nil
            }
        }
        return layout
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let separatorSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))
        let separatorSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: separatorSize, elementKind: "separator", alignment: .top)
        section.boundarySupplementaryItems = [separatorSupplementary]
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(90), heightDimension: .absolute(32))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(32))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10) // Set inter item spacing to 10 pixels
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16)
        
        let boundarySupplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))
        let boundarySupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: boundarySupplementarySize, elementKind: "category-dish-boundary", alignment: .top)
        section.boundarySupplementaryItems = [boundarySupplementaryItem]
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    
    private func createDishSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(160))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(160))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let separatorSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))
        let separatorSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: separatorSize, elementKind: "separator", alignment: .top)
        section.boundarySupplementaryItems = [separatorSupplementary]
        
        return section
    }
}

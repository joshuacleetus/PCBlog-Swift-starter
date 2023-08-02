//
//  ViewController.swift
//  PCBlog-Swift
//
//  Created by Hoan Tran on 8/22/22.
//

import UIKit
import SafariServices

class EmpowerHomeViewController: CompositionalCollectionViewViewController {

    private lazy var viewModel: EmpowerHomeViewModel = EmpowerHomeViewModel(
        imageService: ImageDownloadService()
    )
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private enum Section {
        case main
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = self.viewModel.feedTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.view.backgroundColor = .white
        // set up collection view
        collectionView.contentInset.bottom = 50
        collectionView.register(EmpowerItemCell.self, forCellWithReuseIdentifier: EmpowerItemCell.reuseIdentifier)
        collectionView.delegate = self

        // fetch the feed items
        self.fetchFeedItems()
    }
    
    override func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [unowned self] index, env in
            return self.layoutSection(forIndex: index, environment: env)
        }
    }
}

private extension EmpowerHomeViewController {
    
    func configureDatasource() {
        // Initialize the data source
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmpowerItemCell.reuseIdentifier, for: indexPath) as? EmpowerItemCell else { return UICollectionViewCell() }
            // Configure the cell with the item's data
            if let viewModel = self?.viewModel {
                cell.configure(with: viewModel, at: indexPath.item)
            }
            return cell
        }
        
        // Load initial data into the collection view
        applySnapshot()
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        
        // Generate your items based on the device's view
        let items = viewModel.items
        
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension EmpowerHomeViewController {
    // Create your collection view layout
    private func layoutSection(forIndex index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        //items count per row
        let itemCount = environment.traitCollection.horizontalSizeClass == .compact ? 2 : 3

        // get width of item
        let fractionWidth: CGFloat = 1 / CGFloat(itemCount)

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractionWidth), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .small()
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(fractionWidth))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        return NSCollectionLayoutSection(group: group)
    }
}

private extension EmpowerHomeViewController {
    func fetchFeedItems() {
        viewModel.fetchFeedItems { [weak self] _ in
            DispatchQueue.main.async {
                self?.configureDatasource()
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension EmpowerHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.item(at: indexPath.item)
        openWebviewFor(item: item)
    }
    
    // open webview on cell selection
    func openWebviewFor(item: Item) {
        let svc = SFSafariViewController(url: URL(string: item.url)!)
        present(svc, animated: true, completion: nil)
    }
}

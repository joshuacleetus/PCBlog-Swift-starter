//
//  ViewController.swift
//  PCBlog-Swift
//
//  Created by Hoan Tran on 8/22/22.
//

import UIKit

class EmpowerHomeViewController: UIViewController {
    private var feedItems: [Item] = []
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createCollectionViewLayout()
    )
    private lazy var viewModel: EmpowerHomeViewModel = EmpowerHomeViewModel(
        imageService: ImageDownloadService()
    )

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
        self.prepareCollectionView()
        self.fetchFeedItems()
    }
}

private extension EmpowerHomeViewController {
    func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        splitViewController?.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(EmpowerItemCell.self, forCellWithReuseIdentifier: EmpowerItemCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate(
            [
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        )
    }
}

extension EmpowerHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmpowerItemCell.reuseIdentifier, for: indexPath) as! EmpowerItemCell
        cell.configure(with: self.viewModel, at: indexPath.item)
        return cell
    }
}

private extension EmpowerHomeViewController {
    
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()

        return UICollectionViewCompositionalLayout(
            section: makeSection(),
            configuration: config
        )

        func makeItem() -> NSCollectionLayoutItem {
            let itemSize: NSCollectionLayoutSize
            if UIDevice.current.userInterfaceIdiom == .phone {
                itemSize = NSCollectionLayoutSize(
                   widthDimension: .fractionalWidth(1/2),
                   heightDimension: .fractionalWidth(1/2)
                )
            } else {
                if isSplitView() {
                    itemSize = NSCollectionLayoutSize(
                       widthDimension: .fractionalWidth(1/2),
                       heightDimension: .fractionalWidth(1/2)
                   )
                } else {
                    itemSize = NSCollectionLayoutSize(
                       widthDimension: .fractionalWidth(1/3),
                       heightDimension: .fractionalWidth(1/3)
                   )
                }
            }
            let item = NSCollectionLayoutItem(
                layoutSize: itemSize
            )
            item.contentInsets = .init(top: 0, leading: 4, bottom: 4, trailing: 4)

            return item
        }

        func makeGroup() -> NSCollectionLayoutGroup {
            let groupSize: NSCollectionLayoutSize
            if UIDevice.current.userInterfaceIdiom == .phone {
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/2))
            } else {
                if isSplitView() {
                    groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/2))
                } else {
                    groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/3))
                }
            }
            let ipadCount = isSplitView() ? 2 : 3
            return NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: makeItem(),
                count: UIDevice.current.userInterfaceIdiom == .phone ? 2 : ipadCount
            )
        }

        func makeSection() -> NSCollectionLayoutSection {
            let section = NSCollectionLayoutSection(group: makeGroup())
            section.contentInsets = .init(
                top: 16,
                leading: 0,
                bottom: 0, trailing: 0
            )
            return section
        }
       
        func isSplitView() -> Bool {
           if #available(iOS 14.0, *) {
               return self.traitCollection.horizontalSizeClass == .regular && self.traitCollection.verticalSizeClass == .regular
           } else {
               return self.splitViewController != nil
           }
       }
    }

}

private extension EmpowerHomeViewController {
    func fetchFeedItems() {
        viewModel.fetchFeedItems { [weak self] items in
            self?.feedItems = items
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension EmpowerHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.item(at: indexPath.item)
        if UIDevice.current.userInterfaceIdiom == .phone {
            let detailViewController = EmpowerItemDetailViewController(item: item)
            detailViewController.modalPresentationStyle = .fullScreen
            navigationController?.present(detailViewController, animated: true)
        } else {
            let viewControllerToPresent = EmpowerItemDetailViewController(item: item)
            viewControllerToPresent.modalPresentationStyle = .popover
            let popoverPresentationController = viewControllerToPresent.popoverPresentationController
            popoverPresentationController?.sourceView = self.view // The view from which the popover should be presented
            popoverPresentationController?.sourceRect = self.view.frame // The rectangle in the source view's coordinate system where the popover should point
            present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
}

// MARK: - UISplitViewControllerDelegate

extension EmpowerHomeViewController: UISplitViewControllerDelegate {
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewController.DisplayMode) {
        collectionView.collectionViewLayout = createCollectionViewLayout()
    }
}

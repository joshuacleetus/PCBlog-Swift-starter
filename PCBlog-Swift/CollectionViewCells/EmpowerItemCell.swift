//
//  EmpowerCollectionViewCell.swift
//  PCBlog-Swift
//
//  Created by Joshua Cleetus on 7/28/23.
//

import UIKit

class EmpowerItemCell: UICollectionViewCell {
    static let reuseIdentifier = "ItemCell"
    private let titleLabel = UILabel()
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        // Configure the cell UI components
        // Add image view to the cell
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40) // Set the image height as needed
        ])
        // Add title label to the cell
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }

    func configure(with viewModel: EmpowerHomeViewModel, at index: Int) {
        // Configure the cell with data from the ViewModel
        let item = viewModel.item(at: index)
        titleLabel.text = item.title
        // Load the image from the imageName property of the Article model
        viewModel.fetchImage(for: item) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
}

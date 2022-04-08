//
//  VendorTableViewCell.swift
//  VendorsPreview
//
//  Created by Michał Warchał on 07/04/2022.
//

import UIKit
import Kingfisher

class VendorTableViewCell: UITableViewCell {
    static let identifier = "VendorTableViewCellIdentifier"

    private enum Constants {
        static let marginOffset: CGFloat = 20
        static let imageHeight: CGFloat = 40
    }
    
    private let heroImageView: UIImageView = {
        let label = UIImageView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var nameLabel = makeLabel(with: .preferredFont(forTextStyle: .body))
    
    private lazy var availibilityLabel = makeLabel(with: .preferredFont(forTextStyle: .footnote))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: VendorCellViewModel) {
        nameLabel.text = viewModel.name
        availibilityLabel.text = viewModel.openingHoursRangeText
        heroImageView.kf.setImage(with: viewModel.imageUrl)
    }
    
    private func setupSubview() {
        [heroImageView, infoStackView].forEach(contentView.addSubview)
        [nameLabel, availibilityLabel].forEach(infoStackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            heroImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.marginOffset),
            heroImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            heroImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            heroImageView.widthAnchor.constraint(equalToConstant: Constants.imageHeight),
            
            infoStackView.leftAnchor.constraint(equalTo: heroImageView.rightAnchor, constant: Constants.marginOffset),
            infoStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.marginOffset),
            infoStackView.topAnchor.constraint(equalTo: heroImageView.topAnchor),
            infoStackView.bottomAnchor.constraint(equalTo: heroImageView.bottomAnchor)
        ])
    }
    
    private func makeLabel(with font: UIFont) -> UILabel {
        let label = UILabel()
        label.font = font
        return label
    }
}

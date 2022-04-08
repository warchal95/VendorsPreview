//
//  VendorDetailsView.swift
//  VendorsPreview
//
//  Created by Michał Warchał on 07/04/2022.
//

import UIKit
import Kingfisher

class VendorDetailsView: UIView {
    
    private enum Constants {
        static let marginOffset: CGFloat = 16
        static let imageHeight: CGFloat = 250
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.textContainer.lineFragmentPadding = .zero
        textView.isEditable = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: VendorDetailsViewModel) {
        nameLabel.text = viewModel.name
        imageView.kf.setImage(with: viewModel.imageUrl)
        descriptionTextView.text = viewModel.description + viewModel.description
    }
    
    private func setupConstraints() {
        [imageView, nameLabel, descriptionTextView].forEach(addSubview)
        
        [nameLabel, descriptionTextView].forEach {
            $0.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.marginOffset).isActive = true
            $0.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.marginOffset).isActive = true
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
    
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.marginOffset),
            
            descriptionTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupView() {
        backgroundColor = .white
    }
}

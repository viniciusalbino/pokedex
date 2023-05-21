//
//  EvolutionView.swift
//  onTopPoke
//
//  Created by Vinicius Albino on 20/05/23.
//

import Foundation
import UIKit

class EvolutionView: UIView {
    private var imageView: UIImageView = UIImageView(frame: .zero)
    private var label: UILabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "PlaceholderImage")
        addSubview(imageView)
        
        label.font = .systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize, weight: .bold)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 1
        addSubview(label)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6)
        ])
    }
    
    func fill(name: String, url: String) {
        label.text = name.capitalized
        ImageDownloader.shared.downloadImage(with: url, completionHandler: { image, cached in
            self.imageView.image = image
        }, placeholderImage: nil)
    }
}

import UIKit

class ListCell: UITableViewCell {
    static let reuseIdentifier = "ListCell"
    
    private var iconContainer: UIView = UIView(frame: .zero)
    private var icon: UIImageView = UIImageView(frame: .zero)
    private var titleLabel: UILabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.accessoryType = .disclosureIndicator
        backgroundColor = .clear
        
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.backgroundColor = UIColor.lightGray
        iconContainer.layer.cornerRadius = 10
        iconContainer.clipsToBounds = true
        contentView.addSubview(iconContainer)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.image = UIImage(named: "PlaceholderImage")
        iconContainer.addSubview(icon)
        
        titleLabel.font = .systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize, weight: .bold)
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 1
        contentView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let margins = contentView.layoutMarginsGuide
        
        let widthConstraint = iconContainer.widthAnchor.constraint(equalToConstant: 60)
        widthConstraint.priority = UILayoutPriority(rawValue: 500)
        widthConstraint.isActive = true
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconContainer.widthAnchor.constraint(equalTo: iconContainer.heightAnchor),
            iconContainer.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            iconContainer.topAnchor.constraint(equalTo: margins.topAnchor),
            iconContainer.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            icon.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            icon.heightAnchor.constraint(equalTo: iconContainer.heightAnchor),
            icon.widthAnchor.constraint(equalTo: iconContainer.widthAnchor),
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor)
        ])
    }
    
    func fill(dto: Species) {
        titleLabel.text = dto.name.capitalized
        ImageDownloader.shared.downloadImage(with: dto.imageURL(), completionHandler: { image, cached in
            self.icon.image = image
            self.layoutIfNeeded()
        }, placeholderImage: UIImage(named: "PlaceholderImage"))
    }
}

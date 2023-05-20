import UIKit

class ListCell: UITableViewCell {
    static let reuseIdentifier = "ListCell"
    
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
        backgroundColor = .clear
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        contentView.addSubview(icon)
        
        titleLabel.font = .systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize, weight: .bold)
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 1
        contentView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let margins = contentView.layoutMarginsGuide
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalTo: icon.widthAnchor),
            icon.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            icon.topAnchor.constraint(equalTo: margins.topAnchor),
            icon.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor)
        ])
    }
    
    func fill(dto: Species) {
        titleLabel.text = dto.name.capitalized
        ImageDownloader.shared.downloadImage(with: dto.imageURL(), completionHandler: { image, cached in
            self.icon.image = image
        }, placeholderImage: UIImage(named: "placeholder"))
    }
}

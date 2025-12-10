import UIKit
import SnapKit
import SDWebImage

final class MoviesCollectionViewCell: UICollectionViewCell {
    static let identifier = "MoviesCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private let posterView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "#111827")
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(named: "#9CA3AF")
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
}

extension MoviesCollectionViewCell {
    func configureCell(with movie: Movie) {
        nameLabel.text = movie.name
        posterView.sd_setImage(with: movie.posterURL)
        genreLabel.text = movie.genres.first
    }
    
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        contentView.addSubviews(posterView, nameLabel, genreLabel)
    }
    
    func setupConstraints() {
        posterView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(164)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(posterView.snp.bottom).offset(8)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
    }
}


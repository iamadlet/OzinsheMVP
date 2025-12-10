import UIKit
import SnapKit
import SDWebImage

final class BannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "BannerCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let categoryContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "#7E2DFC")
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        label.textColor = .white
        return label
    }()
    
    private let movieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "#111827")
        return label
    }()
    
    private let movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(named: "#9CA3AF")
        return label
    }()
}

extension BannerCollectionViewCell {
    func configureCell(with movie: Movie) {
        categoryLabel.text = movie.categories[0]
        movieLabel.text = movie.name
        movieDescriptionLabel.text = movie.description
        imageView.sd_setImage(with: movie.posterURL)
    }
    
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        contentView.addSubviews(imageView, movieLabel, movieDescriptionLabel)
        imageView.addSubview(categoryContainer)
        categoryContainer.addSubview(categoryLabel)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(164)
        }
        
        categoryContainer.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview().inset(4)
        }
        
        movieLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        
        movieDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(movieLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

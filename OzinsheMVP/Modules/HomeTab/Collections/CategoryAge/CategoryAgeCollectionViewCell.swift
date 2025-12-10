import UIKit
import SnapKit
import SDWebImage

final class CategoryAgeCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryAgeCollectionViewCell"
    
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(named: "#F9FAFB")
        return label
    }()
}


extension CategoryAgeCollectionViewCell {
    func configureCell(with categoryAge: CategoryAge) {
        titleLabel.text = categoryAge.name
        imageView.sd_setImage(with: categoryAge.link)
    }
    
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        contentView.addSubview(imageView)
        imageView.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(112)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(imageView.snp.center)
        }
    }
}

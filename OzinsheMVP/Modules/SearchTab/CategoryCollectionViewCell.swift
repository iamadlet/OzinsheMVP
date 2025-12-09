import UIKit
import SnapKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCell"
    
    let backView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "#F3F4F6")
        view.layer.cornerRadius = 8
        return view
    }()
    
    let label: UILabel = {
        let labelCell = UILabel()
        labelCell.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        labelCell.textColor = UIColor(named: "#374151")
        
        return labelCell
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        backgroundColor = UIColor(named: "#FFFFFF")
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCollectionViewCell {
    func configureCell(with category: Category) {
        label.text = category.name
    }
    
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        contentView.addSubview(backView)
        backView.addSubview(label)
        
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        label.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(16)
            make.bottom.top.equalToSuperview()
            make.height.equalTo(34)
        }
    }
}

import UIKit
import SnapKit

class LanguageTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let identifier = "LanguageCell"
    
    let languageLabel = {
        let label = UILabel()
        
        label.text = "English"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        label.textColor = UIColor(named: "#111827")
        
        return label
    }()
    
    let divider = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "LangDivider")
        
        return view
    }()
    
    let checkImage = {
        let image = UIImageView()
        
        image.image = UIImage(named: "Check")
        
        return image
    }()
}

extension LanguageTableViewCell {
    func configureCell(with language: String) {
        self.languageLabel.text = language
        self.checkImage.isHidden = true
        self.backgroundColor = UIColor(named: "#FFFFFF")
    }
    
    func setupSubviews() {
        contentView.addSubviews(languageLabel, divider, checkImage)
    }
    
    func setupConstraints() {
        languageLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        checkImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(24)
        }
        
        divider.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}

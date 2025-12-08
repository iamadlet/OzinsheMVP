import UIKit
import SnapKit
import SDWebImage

final class MovieTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let identifier = "MovieCell"
    
    lazy var posterImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "Image")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var titleLabel = {
        let label = UILabel()
        
        label.text = "Tulips' Land"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "#111827")
        
        return label
    }()
    
    lazy var subtitleLabel = {
        let label = UILabel()
        
        label.text = "2020 • TV Series • Cartoon"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(named: "#9CA3AF")
        
        return label
    }()
    
    lazy var playView = {
        let view = UIView()
        
        let imageView = UIImageView(image: UIImage(named: "Play-Filled"))
        let label = UILabel()
        
        view.backgroundColor = UIColor(named: "#F8EEFF")
        view.layer.cornerRadius = 8
        
        label.text = "Watch"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
        label.textColor = UIColor(named: "#9753F0")
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.verticalEdges.equalToSuperview().inset(5)
            make.size.equalTo(16)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(12)
        }
        
        return view
    }()
    
    lazy var bottomView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "#D1D5DB")
        
        return view
    }()
}

extension MovieTableViewCell {
    func configureCell(with movie: Movie) {
        self.backgroundColor = UIColor(named: "#FFFFFF")
        self.titleLabel.text = movie.name
        var subtitle: [String] = []
        subtitle.append(movie.yearText)
        subtitle.append(contentsOf: movie.genres)
        let subtitleText = subtitle.joined(separator: " • ")
        self.subtitleLabel.text = subtitleText
        self.posterImageView.sd_setImage(with: movie.posterURL)
        
    }
    
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }    
    
    func setupSubviews() {
        self.addSubviews(posterImageView, titleLabel, subtitleLabel, playView, bottomView)
    }
    
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.width.equalTo(71)
            make.height.equalTo(104)
            make.verticalEdges.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.equalTo(posterImageView.snp.trailing).offset(17)
            make.trailing.equalToSuperview().inset(24)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(17)
            make.trailing.equalToSuperview().inset(24)
        }
        
        playView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
            make.leading.equalTo(posterImageView.snp.trailing).offset(17)
        }
        
        bottomView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(0)
        }
    }
}

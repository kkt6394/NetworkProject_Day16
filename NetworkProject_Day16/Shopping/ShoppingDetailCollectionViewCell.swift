//
//  ShoppingDetailCollectionViewCell.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/21/26.
//

import UIKit
import SnapKit
import Kingfisher

class ShoppingDetailCollectionViewCell: UICollectionViewCell {
    
    let imageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info.square")
        return imageView
    }()
    
    let likeBtn = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        return button
    }()
    
    let mallNameLabel = {
        let label = UILabel()
        label.text = "mallNameLabel"
        label.textColor = .systemGray4
        label.lineBreakMode = .byTruncatingTail
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let itemNameLabel = {
        let label = UILabel()
        label.text = "itemNameLabel"
        label.textColor = .systemGray6
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let priceLabel = {
        let label = UILabel()
        label.text = "priceLabel"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(data: ShoppingData.Items) {
        let url = URL(string: data.image)
        imageView.kf.setImage(with: url)
        mallNameLabel.text = data.mallName
        itemNameLabel.text = data.title
        priceLabel.text = Int(data.lprice)?.formatted()
    }
}

extension ShoppingDetailCollectionViewCell: ViewDesign {
    func configureUI() {
        [
            imageView, likeBtn, mallNameLabel, itemNameLabel, priceLabel
        ].forEach { contentView.addSubview($0) }
        
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.size.equalTo(180)
        }
        
        likeBtn.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.trailing.equalTo(imageView.snp.trailing).inset(4)
            make.bottom.equalTo(imageView.snp.bottom).inset(4)
        }
        
        mallNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.leading.equalTo(imageView.snp.leading).offset(10)
        }
        
        itemNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mallNameLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(imageView).inset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(itemNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(imageView.snp.leading).offset(10)
        }
        
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        likeBtn.cornerConfiguration = .capsule()

        
    }
    
    
}

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
        button.setImage(UIImage(systemName: "info.circle"), for: .application)
        return button
    }()
    
    let mallNameLabel = {
        let label = UILabel()
        label.text = "mallNameLabel"
        return label
    }()
    
    let itemNameLabel = {
        let label = UILabel()
        label.text = "itemNameLabel"
        return label
    }()
    
    let priceLabel = {
        let label = UILabel()
        label.text = "priceLabel"
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
        priceLabel.text = data.lprice
    }
}

extension ShoppingDetailCollectionViewCell: ViewDesign {
    func configureUI() {
        [
            imageView, likeBtn, mallNameLabel, itemNameLabel, priceLabel
        ].forEach { contentView.addSubview($0) }
        
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        likeBtn.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.trailing.equalTo(imageView.snp.trailing).inset(20)
            make.bottom.equalTo(imageView.snp.bottom).inset(20)
        }
        
        mallNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.leading.equalTo(imageView.snp.leading).offset(10)
        }
        
        itemNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mallNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(imageView.snp.leading).offset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(itemNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(imageView.snp.leading).offset(10)
        }

        
    }
    
    
}

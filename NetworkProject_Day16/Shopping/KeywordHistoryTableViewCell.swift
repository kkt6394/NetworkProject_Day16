//
//  KeywordHistoryTableViewCell.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/22/26.
//

import UIKit
import SnapKit

class KeywordHistoryTableViewCell: UITableViewCell {

    let magnifyingGlassImage = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        return imageView
    }()
    
    let keywordLabel = {
        let label = UILabel()
        return label
    }()
    
    let deleteBtn = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "x.circle"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension KeywordHistoryTableViewCell: ViewDesign {
    func configureUI() {
        [
            magnifyingGlassImage, keywordLabel, deleteBtn
        ].forEach {
            contentView.addSubview($0)
        }
        
        magnifyingGlassImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(40)
        }
        
        keywordLabel.snp.makeConstraints { make in
            make.centerY.equalTo(magnifyingGlassImage)
            make.leading.equalTo(magnifyingGlassImage.snp.trailing).offset(28)
        }
        
        deleteBtn.snp.makeConstraints { make in
            make.centerY.equalTo(magnifyingGlassImage)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
}

//
//  BoxOfficeTableViewCell.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/20/26.
//

import UIKit
import SnapKit

class BoxOfficeTableViewCell: UITableViewCell {

    let rankLabel = {
        let label = UILabel()
        return label
    }()
    
    let titleLabel = {
        let label = UILabel()
        return label
    }()
    let dateLabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(data: Movie.BoxOfficeResult.DailyBoxOfficeList) {
        rankLabel.text = data.rank
        titleLabel.text = data.movieNm
        dateLabel.text = data.openDt
    }
}

extension BoxOfficeTableViewCell: ViewDesign {
    func configureUI() {
        [
            rankLabel, titleLabel, dateLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        
        rankLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(rankLabel.snp.trailing).offset(24)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    
}

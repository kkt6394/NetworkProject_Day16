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
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    let dateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
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
        contentView.backgroundColor = .black
        
        rankLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(rankLabel.snp.trailing).offset(10)
            make.trailing.equalTo(dateLabel.snp.leading).offset(-10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    
}

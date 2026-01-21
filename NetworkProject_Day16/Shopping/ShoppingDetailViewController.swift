//
//  ShoppingDetailViewController.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/21/26.
//

import UIKit
import SnapKit
import Kingfisher

class ShoppingDetailViewController: UIViewController {

    let resultCountLabel = {
        let label = UILabel()
        return label
    }()
    
    let accuracyBtn = {
        let button = UIButton()
        button.setTitle("정확도", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .black
        return button
    }()
    
    let dateBtn = {
        let button = UIButton()
        button.setTitle("날짜순", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .black
        return button
    }()

    let hPriceBtn = {
        let button = UIButton()
        button.setTitle("가격높은순", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .black
        return button
    }()

    let lPriceBtn = {
        let button = UIButton()
        button.setTitle("가격낮은순", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .black
        return button
    }()
    
    let collectionView = UICollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

    }
    
}

extension ShoppingDetailViewController: ViewDesign {
    func configureUI() {
        navigationItem.title = "TITLE"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        [
            resultCountLabel, accuracyBtn, dateBtn, hPriceBtn, lPriceBtn, collectionView
        ].forEach { view.addSubview($0) }
        
        resultCountLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        accuracyBtn.snp.makeConstraints { make in
            make.top.equalTo(resultCountLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        dateBtn.snp.makeConstraints { make in
            make.top.equalTo(resultCountLabel.snp.bottom).offset(10)
            make.leading.equalTo(accuracyBtn.snp.trailing).offset(10)
        }
        hPriceBtn.snp.makeConstraints { make in
            make.top.equalTo(resultCountLabel.snp.bottom).offset(10)
            make.leading.equalTo(dateBtn.snp.trailing).offset(10)
        }
        lPriceBtn.snp.makeConstraints { make in
            make.top.equalTo(resultCountLabel.snp.bottom).offset(10)
            make.leading.equalTo(hPriceBtn.snp.trailing).offset(10)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(accuracyBtn.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
        
        
    }
    
    
}

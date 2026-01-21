//
//  ShoppingDetailViewController.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/21/26.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class ShoppingDetailViewController: UIViewController {
    var navigationItemTitle: String?
    
    var currentData: [ShoppingData.Items] = []
    
    var keyword = "캠핑카"

    lazy var resultCountLabel = {
        let label = UILabel()
        label.textColor = .green
        print(#function)
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
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: setCollectionViewLayout()
    )
    
    func setCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = 180
        let height = 300
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return layout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setCollectionView()
        callRequest()
    }
    
    func callRequest() {
        let url = "https://openapi.naver.com/v1/search/shop.json"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        let param: Parameters = [
            "query": keyword,
            "display": 100
        ]
        AF.request(
            url,
            method: .get,
            parameters: param,
            encoding: URLEncoding.queryString,
            headers: header
        )
            .responseDecodable(of: ShoppingData.self) { response in
                switch response.result {
                case .success(let value):
                    print(#function)
                    DispatchQueue.main.async {
                        self.resultCountLabel.text = "\(value.total.formatted()) 개의 검색 결과"
                    }
                    self.currentData = value.items
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            ShoppingDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: String(
                describing: ShoppingDetailCollectionViewCell.self
            )
        )
    }
}

extension ShoppingDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ShoppingDetailCollectionViewCell.self), for: indexPath) as? ShoppingDetailCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(data: currentData[indexPath.item])
        return cell
    }
}

extension ShoppingDetailViewController: ViewDesign {
    func configureUI() {
        print(self, #function)
        navigationItem.title = navigationItemTitle
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        collectionView.backgroundColor = .black
        
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


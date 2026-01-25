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
    
    var currentSort = Sort.sim
    
    var total = 1
    var start = 1
    
    enum Sort: String {
        case sim
        case date
        case asc
        case dsc
    }
    
    var navigationItemTitle: String?
    
    var currentData: [ShoppingData.Items] = []
    
    var keyword = ""
    
    lazy var resultCountLabel = {
        let label = UILabel()
        label.textColor = .green
        print(#function)
        return label
    }()
    
    let accuracyBtn = ShoppingDetailViewButton(buttonTitle: "정확도")
    let dateBtn = ShoppingDetailViewButton(buttonTitle: "날짜순")
    let hPriceBtn = ShoppingDetailViewButton(buttonTitle: "가격높은순")
    let lPriceBtn = ShoppingDetailViewButton(buttonTitle: "가격낮은순")
    
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
        callRequest(sort: .sim)
        accuracyBtn.backgroundColor = .white
        accuracyBtn.setTitleColor(UIColor.black, for: .normal)
        buttonTargetConfigure()
    }
    
    func buttonTargetConfigure() {
        accuracyBtn.addTarget(
            self,
            action: #selector(accuracyBtnTapped),
            for: .touchUpInside
        )
        dateBtn.addTarget(
            self,
            action: #selector(dateBtnTapped),
            for: .touchUpInside
        )
        hPriceBtn.addTarget(
            self,
            action: #selector(hPriceBtnTapped),
            for: .touchUpInside
        )
        lPriceBtn.addTarget(
            self,
            action: #selector(lPriceBtnTapped),
            for: .touchUpInside
        )
    }
    
    // 줄일 방법 질문.
    // 1. 상태 관리.
    // 2. 메서드 화.
    @objc
    func accuracyBtnTapped() {
        callRequest(sort: .sim)
        accuracyBtn.backgroundColor = .white
        accuracyBtn.setTitleColor(UIColor.black, for: .normal)
        dateBtn.backgroundColor = .black
        dateBtn.titleLabel?.textColor = .white
        hPriceBtn.backgroundColor = .black
        hPriceBtn.titleLabel?.textColor = .white
        lPriceBtn.backgroundColor = .black
        lPriceBtn.titleLabel?.textColor = .white
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
    @objc
    func dateBtnTapped() {
        callRequest(sort: .date)
        dateBtn.backgroundColor = .white
        dateBtn.setTitleColor(UIColor.black, for: .normal)
        accuracyBtn.backgroundColor = .black
        accuracyBtn.titleLabel?.textColor = .white
        hPriceBtn.backgroundColor = .black
        hPriceBtn.titleLabel?.textColor = .white
        lPriceBtn.backgroundColor = .black
        lPriceBtn.titleLabel?.textColor = .white
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
    @objc
    func hPriceBtnTapped() {
        callRequest(sort: .dsc)
        hPriceBtn.backgroundColor = .white
        hPriceBtn.setTitleColor(UIColor.black, for: .normal)
        accuracyBtn.backgroundColor = .black
        accuracyBtn.titleLabel?.textColor = .white
        dateBtn.backgroundColor = .black
        dateBtn.titleLabel?.textColor = .white
        lPriceBtn.backgroundColor = .black
        lPriceBtn.titleLabel?.textColor = .white
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
    @objc
    func lPriceBtnTapped() {
        callRequest(sort: .asc)
        lPriceBtn.backgroundColor = .white
        lPriceBtn.setTitleColor(UIColor.black, for: .normal)
        accuracyBtn.backgroundColor = .black
        accuracyBtn.titleLabel?.textColor = .white
        dateBtn.backgroundColor = .black
        dateBtn.titleLabel?.textColor = .white
        hPriceBtn.backgroundColor = .black
        hPriceBtn.titleLabel?.textColor = .white
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
    func callRequest(sort: Sort) {
        currentSort = sort
        let url = "https://openapi.naver.com/v1/search/shop.json"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "APIKey.clientID",
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        let param: Parameters = [
            "query": keyword,
            "display": 30,
            "start": start,
            "sort": sort
        ]
        let request = AF.request(
            url,
            method: .get,
            parameters: param,
            encoding: URLEncoding.queryString,
            headers: header
        )
        request
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ShoppingData.self) { response in
                switch response.result {
                case .success(let value):
                    
                    print(#function)
                    print("성공", response.response?.statusCode)
                    self.resultCountLabel.text = "\(value.total.formatted()) 개의 검색 결과"
                    self.currentData.append(contentsOf: value.items)
                    self.collectionView.reloadData()
                    self.total = value.total
                    print(">>>", request, "<<<")
                    
                case .failure(let error):
                    if let data = response.data {
                        if let naverError = try? JSONDecoder().decode(NaverAPIError.self, from: data) {
                            print("코드: ", naverError.errorCode)
                            print("에러 내용: ", naverError.errorMessage)
                        }
                        print(error)
                        print("실패", response.response?.statusCode)
                    }
                    var finalError: NaverError = .apiError
                    
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 429:
                            finalError = .requestLimit
                        case 500...599:
                            finalError = .serverMaintenance
                        case 400, 401, 403, 404:
                            finalError = .apiError
                        default:
                            finalError = .networkIssue
                        }
                    } else if error.isSessionTaskError {
                        finalError = .networkIssue
                    }
                    self.showAlert(message: finalError.alertMessage)
                }
            }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "안내", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard total > currentData.count else { return }
        if indexPath.item == currentData.count - 4 {
            start += 1
            callRequest(sort: currentSort)
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


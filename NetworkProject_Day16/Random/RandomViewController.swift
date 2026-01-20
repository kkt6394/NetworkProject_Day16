//
//  RandomViewController.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/20/26.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class RandomViewController: UIViewController {

    let button = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 불러오기", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    let imageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()
    
    let authorLabel = {
        let label = UILabel()
        label.text = "authorLabel"
        return label
    }()
    
    let resolutionLabel = {
        let label = UILabel()
        label.text = "resolutionLabel"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        configureBtn()
        
        
    }
    
    @objc func btnTapped() {
        
        let randomNum = Int.random(in: 1...10)
        let url = "https://picsum.photos/id/\(randomNum)/info"
        AF.request(url, method: .get)
            .responseDecodable(of: Picsum.self) { response in
                switch response.result {
                case .success(let value):
                    dump(value)
                    let url = URL(string: value.download_url)
                    self.imageView.kf.setImage(with: url)
                    self.authorLabel.text = "작가: \(value.author)"
                    self.resolutionLabel.text = "\(value.width) x \(value.height)"
                    
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}

extension RandomViewController: ViewDesign {
    func configureUI() {
        
        [
            button, imageView, authorLabel, resolutionLabel
        ].forEach {
            view.addSubview($0)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(240)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        resolutionLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureBtn() {
        button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
    }
    
    
}

//
//  BoxOfficeViewController.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/20/26.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class BoxOfficeViewController: UIViewController {
    
    var data: [Movie.BoxOfficeResult.DailyBoxOfficeList] = []
    
    let textField = {
        let textField = UITextField()
        textField.placeholder = "날짜를 입력하세요 ex)20261226"
        return textField
    }()

    let searchBtn = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        return button
    }()
    
    lazy var tableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            BoxOfficeTableViewCell.self,
            forCellReuseIdentifier: String(describing: BoxOfficeTableViewCell.self)
        )
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .white
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=410a56189da48afa0ba7d22dc6e31d27&targetDt=20250723"
        AF.request(url, method: .get)
            .responseDecodable(of: Movie.self) { response in
                switch response.result {
                case .success(let value):
                    dump(value)
                    self.data = value.boxOfficeResult.dailyBoxOfficeList
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
    }
    

}

extension BoxOfficeViewController: ViewDesign {
    func configureUI() {
        [
            textField, searchBtn, tableView
        ].forEach {
            view.addSubview($0)
        }
    }
}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BoxOfficeTableViewCell.self), for: indexPath) as? BoxOfficeTableViewCell else { return UITableViewCell() }
        cell.configureCell(data: data[indexPath.row])
        return cell
    }
    
    
}

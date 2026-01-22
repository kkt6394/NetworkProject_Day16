//
//  ShoppingViewController.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/21/26.
//

import UIKit
import SnapKit

class ShoppingViewController: UIViewController {

    lazy var searchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.barTintColor = .clear
        return searchBar
    }()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    }
}

extension ShoppingViewController: ViewDesign {
    func configureUI() {
        view.backgroundColor = .black
        navigationItem.title = "도봉러의 쇼핑쇼핑"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        [
            searchBar, tableView
        ].forEach { view.addSubview($0) }
                
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().offset(10)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(400)
        }
    }
}

extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: KeywordHistoryTableViewCell.self), for: indexPath) as? KeywordHistoryTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            KeywordHistoryTableViewCell.self,
            forCellReuseIdentifier: String(describing: KeywordHistoryTableViewCell.self)
        )
        tableView.rowHeight = 80
    }
}

extension ShoppingViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(self, #function)
        let vc = ShoppingDetailViewController()
        guard let text = searchBar.text, text.count >= 2 else { return }
        vc.keyword = text
        vc.navigationItemTitle = text
        navigationController?.pushViewController(vc, animated: true)
    }
}

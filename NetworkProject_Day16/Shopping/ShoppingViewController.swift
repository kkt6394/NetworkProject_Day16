//
//  ShoppingViewController.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/21/26.
//

import UIKit
import SnapKit

class ShoppingViewController: UIViewController {

    var userDefaultsArr: [String] = []
    
    
    lazy var searchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.barTintColor = .clear
        return searchBar
    }()
    
    let tableView = UITableView()
    
    lazy var headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
    
    let recentKeywordLabel = {
        let label = UILabel()
        label.text = "최근 검색어"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let deleteBtn = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        userDefaultsArr = UserDefaults.standard.array(forKey: "keyword") as? [String] ?? []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        tableView.isHidden = true
    }
    
    @objc
    func deleteBtnTapped() {
        userDefaultsArr.removeAll()
        UserDefaults.standard.set(userDefaultsArr, forKey: "keyword")

        tableView.reloadData()
    }
    
    @objc
    func deleteBtnTapped2(_ sender: UIButton) {
        userDefaultsArr.remove(at: sender.tag)
        UserDefaults.standard.set(userDefaultsArr, forKey: "keyword")

        tableView.reloadData()
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
        
        [
            recentKeywordLabel, deleteBtn
        ].forEach { headerView.addSubview($0) }
                
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(185)
        }
        
        recentKeywordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        deleteBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
    }
}

extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userDefaultsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: KeywordHistoryTableViewCell.self), for: indexPath) as? KeywordHistoryTableViewCell else { return UITableViewCell() }
        cell.configureCell(data: userDefaultsArr[indexPath.row])
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnTapped2), for: .touchUpInside)
        return cell
    }
    

        
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            KeywordHistoryTableViewCell.self,
            forCellReuseIdentifier: String(describing: KeywordHistoryTableViewCell.self)
        )
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        tableView.tableHeaderView = headerView
        deleteBtn.addTarget(self, action: #selector(deleteBtnTapped), for: .touchUpInside)
    }
}

extension ShoppingViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(self, #function)
        let vc = ShoppingDetailViewController()
        guard let text = searchBar.text/*, text.count >= 2*/ else { return }
        vc.keyword = text
        vc.navigationItemTitle = text
        
        
//        guard let saved = UserDefaults.standard.string(forKey: "keyword") else { return }

        if userDefaultsArr.contains(text) {
            searchBar.resignFirstResponder()
            navigationController?.pushViewController(vc, animated: true)


        } else {
            userDefaultsArr.insert(text, at: 0)
            UserDefaults.standard.set(userDefaultsArr, forKey: "keyword")
            searchBar.resignFirstResponder()
            navigationController?.pushViewController(vc, animated: true)

        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        if userDefaultsArr.isEmpty {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
        print(">", userDefaultsArr)
        tableView.reloadData()
        print(#function)
    }
        
    
}

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
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

extension ShoppingViewController: ViewDesign {
    func configureUI() {
        view.backgroundColor = .black
        navigationItem.title = "도봉러의 쇼핑쇼핑"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        [
            searchBar
        ].forEach { view.addSubview($0) }
                
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().offset(10)
        }
    }
    
    
}

extension ShoppingViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(self, #function)
        let vc = ShoppingDetailViewController()
        guard let text = searchBar.text else { return }
        vc.keyword = text
        vc.navigationItemTitle = text
        navigationController?.pushViewController(vc, animated: true)
    }
}

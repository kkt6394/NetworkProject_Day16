//
//  ViewController.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/20/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var randomBtn: UIButton!
    
    @IBOutlet var boxOfiiceBtn: UIButton!
    
    @IBOutlet var shoppingBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomBtn.backgroundColor = .systemRed
        boxOfiiceBtn.backgroundColor = .systemGreen
        shoppingBtn.backgroundColor = .systemYellow
    }

    @IBAction func randomBtnTapped(_ sender: UIButton) {
        let vc1 = RandomViewController()

        navigationController?.pushViewController(vc1, animated: true)
    }
    
    @IBAction func boxOfficeBtnTapped(_ sender: UIButton) {
        let vc2 = BoxOfficeViewController()

        navigationController?.pushViewController(vc2, animated: true)

    }
    
    @IBAction func shoppingBtnTapped(_ sender: UIButton) {
        let vc = ShoppingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


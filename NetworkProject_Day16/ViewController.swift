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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func randomBtnTapped(_ sender: UIButton) {
        let vc = RandomViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func boxOfficeBtnTapped(_ sender: UIButton) {
        let vc = BoxOfficeViewController()
        navigationController?.pushViewController(vc, animated: true)

    }
}


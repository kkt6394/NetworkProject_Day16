//
//  ShoppingDetailViewButton.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/22/26.
//

import UIKit

class ShoppingDetailViewButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(buttonTitle: String) {
        super.init(frame: .zero)
        self.setTitle(buttonTitle, for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = .black
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}

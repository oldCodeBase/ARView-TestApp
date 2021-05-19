//
//  SecondaryLabel.swift
//  ARView-TestApp
//
//  Created by Ibragim Akaev on 19/05/2021.
//

import UIKit

class CustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(textColour: UIColor = .label, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        self.init(frame: .zero)
        textColor = textColour
        font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        adjustsFontSizeToFitWidth                 = true
        minimumScaleFactor                        = 0.90
        lineBreakMode                             = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

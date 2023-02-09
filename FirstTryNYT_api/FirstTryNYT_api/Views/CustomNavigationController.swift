//
//  CustomNavigationController.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/8/23.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setFont()
    }
    
    private func setFont() {
        extendedLayoutIncludesOpaqueBars = true
        let font = FontSupport.giveMeFont(type: .logoFont)
        let attributes = [NSAttributedString.Key.font: font]
        self.navigationBar.titleTextAttributes = attributes
        self.navigationBar.tintColor = .label
    }
}

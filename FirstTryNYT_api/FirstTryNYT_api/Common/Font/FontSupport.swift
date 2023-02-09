//
//  FontSupport.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/8/23.
//

import Foundation
import UIKit

class FontSupport {
    enum FontType {
        case logoFont
        case titleFont
        case normalFont
        case smallFont
    }
    static func giveMeFont(type: FontType) -> UIFont {
        switch type {
        case .logoFont:
            let font = UIFont(name: "WilsonWells", size: 27)!
            return font
        case .titleFont:
            let font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 19)!
//            let font = UIFont(name: "Georgia-Bold", size: 31)!
            return font
        case .normalFont:
            let font = UIFont(name: "TimesNewRomanPSMT", size: 19)!
            return font
        case .smallFont:
            let font = UIFont(name: "TimesNewRomanPSMT", size: 18)!
            return font
        }
    }
}

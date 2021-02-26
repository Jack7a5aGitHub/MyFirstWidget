//
//  Utils.swift
//  MyWidgetExtension
//
//  Created by Jack Wong on 2021/02/26.
//

import Foundation
import UIKit

struct Utils {
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        formatter.usesGroupingSeparator  = true
        return formatter
    }()
    
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter
    }()
    
    static func smallWidgetWidth() -> CGFloat {
        switch UIScreen.main.bounds.size {
        case CGSize(width: 414, height: 896):
            return 169
        case CGSize(width: 375, height: 812):
            return 155
        case CGSize(width: 414, height: 736):
            return 159
        case CGSize(width: 375, height: 667):
            return 148
        case CGSize(width: 320, height: 568):
            return 141
        default:
            return 155
        }
    }
    
    static func longWidgetWidth() -> CGFloat {
        switch UIScreen.main.bounds.size {
        case CGSize(width: 414, height: 896):
            return 360
        case CGSize(width: 375, height: 812):
            return 329
        case CGSize(width: 414, height: 736):
            return 348
        case CGSize(width: 375, height: 667):
            return 321
        case CGSize(width: 320, height: 568):
            return 292
        default:
            return 155
        }
    }
}


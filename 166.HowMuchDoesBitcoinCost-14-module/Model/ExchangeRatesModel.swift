//
//  ExchangeRatesModel.swift
//  166.HowMuchDoesBitcoinCost-14-module
//
//  Created by Валентин Картошкин on 26.02.2025.
//

import Foundation

struct ExchangeRatesModel {
    let ratesModel: Double
    var ratesString: String {
        return String(format: "%.2f", ratesModel)
    }
}

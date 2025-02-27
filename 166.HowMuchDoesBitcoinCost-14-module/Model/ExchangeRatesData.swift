//
//  ExchangeRatesData.swift
//  166.HowMuchDoesBitcoinCost-14-module
//
//  Created by Валентин Картошкин on 26.02.2025.
//

import Foundation

struct ExchangeRatesData: Codable {
    let rate: Double
}
/*
Рабочий url-запрос https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=732f4862-20f4-43b4-a331-1b5276d8e08a выдает
{
  "time": "2025-02-25T19:22:29.0000000Z",
  "asset_id_base": "BTC",
  "asset_id_quote": "USD",
  "rate": 86465.7349832354
}
*/

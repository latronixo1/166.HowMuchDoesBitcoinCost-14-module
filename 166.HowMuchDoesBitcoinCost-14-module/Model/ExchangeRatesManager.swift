//
//  ExchangeRatesManager.swift
//  166.HowMuchDoesBitcoinCost-14-module
//
//  Created by Валентин Картошкин on 26.02.2025.
//

import Foundation
import UIKit

protocol ExchangeRatesManagerDelegate {
    func didUpdateExchangeRates(exchangeRates: ExchangeRatesModel)
    func didFailWithError(error: Error)
}

struct ExchangeRatesManager {
    //базовый URL
    let exchangeRatesURLFirst = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let exchangeRatesURLSecond = "?apikey=\(Constants.id)"
    
    //делегат
    var delegate: ExchangeRatesManagerDelegate?
    
    //функция получения данных о курсе, которая будет вызываться в контроллере
    func fetchExchangeRates(currency: String){  //перевод currency - валюта
        let urlString = exchangeRatesURLFirst + currency + exchangeRatesURLSecond
        print("выполняем запрос \(urlString)")
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        //1. создаем URL
        guard let url = URL(string: urlString) else { return }
        
        //2. cоздаем URL сессию
        let session = URLSession(configuration: .default)
        
        //3. Создаем задание для URL-сессии
        let task = session.dataTask(with: url) { data, response, error in   //data, response, error  - это то что мы получим в ответ
            //data - наши данные
            //response -
            //error
            if let error {
                delegate?.didFailWithError(error: error)
                return
            }
            
            //безопасно извлекаем данные
            guard let safeData = data else { return }
            guard let exchangeRates = parseJSON(safeData) else { return }
            delegate?.didUpdateExchangeRates(exchangeRates: exchangeRates)
        }
        
        //4. Запускаем задание на выполнение
        task.resume()
    }
    
    func parseJSON(_ exchangeRatesData: Data) -> ExchangeRatesModel? {
        let decoder = JSONDecoder()
        do {
            print("exchangeRatesData: \(exchangeRatesData)")
            
            if let jsonResponce = String(data: exchangeRatesData, encoding: String.Encoding.utf8) {
                print("Response: \(jsonResponce)")
            }
            
            //пробуем декодировать (отбросить ненужные переменные из сырых данных в экземпляр структуры ExchangeRatesData, которую мы написали для этих сырых данных)
            let decodedData = try decoder.decode(ExchangeRatesData.self, from: exchangeRatesData)
            
            let rate = decodedData.rate
            
            let exchangeRates = ExchangeRatesModel(ratesModel: rate)
            return exchangeRates
        } catch let error {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}

//
//  ViewController.swift
//  166.HowMuchDoesBitcoinCost-14-module
//
//  Created by Валентин Картошкин on 25.02.2025.
//

import UIKit
//import SnapKit

class ViewController: UIViewController {
    private lazy var mainLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 25, weight: .black)
        element.numberOfLines = 0
        element.textAlignment = .center
        element.text = "Курс биткоина"
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var exchangeRatesMananger = ExchangeRatesManager()

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupConstraints()
        setDelegates()
        //отправим запрос на api
        sendRequestExchangeRates()
    }

    // MARK: - Private Methods
    
    private func setDelegates(){
        exchangeRatesMananger.delegate = self
    }
    
    
    func setViews() {
        view.addSubview(mainLabel)
        view.backgroundColor = .gray
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
    }

    func sendRequestExchangeRates() {
        exchangeRatesMananger.fetchExchangeRates(currency: "USD")
    }
}

extension ViewController: ExchangeRatesManagerDelegate {
    
    func didUpdateExchangeRates(exchangeRates: ExchangeRatesModel) {
        DispatchQueue.main.async {
            self.mainLabel.text = "За один биткоин нынче просят \(exchangeRates.ratesString) долларов"
        }
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
}

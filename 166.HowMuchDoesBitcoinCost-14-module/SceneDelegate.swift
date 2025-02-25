//
//  SceneDelegate.swift
//  166.HowMuchDoesBitcoinCost-14-module
//
//  Created by Валентин Картошкин on 25.02.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }   //создаем нашу сцену
        window = UIWindow(windowScene: windowScene) //инициализируем наш window с помощью windowScene
        window?.rootViewController = ViewController()   //ставим ему наш ViewController в качестве рут
        window?.makeKeyAndVisible()
    }
    
}

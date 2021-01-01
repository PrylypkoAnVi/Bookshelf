//
//  SceneDelegate.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import UIKit
import XServiceLocator

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var container: Container?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let window = window else {
            return
        }
        register(AppRouter(window: window), for: Router.self)
        registerObjects()
        let firstDestination = SearchScreenDestination()
        resolve(Router.self).route(to: firstDestination)
    }

    private func registerObjects() {
        
    }

}

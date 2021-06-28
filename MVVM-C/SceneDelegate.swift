//
//  SceneDelegate.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 24/06/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        self.appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
    }
}


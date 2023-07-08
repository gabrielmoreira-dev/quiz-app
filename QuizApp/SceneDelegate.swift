//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by Gabriel on 14/05/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = scene as? UIWindowScene else { return }
        
        let viewController = QuestionViewController(question: "Q1", options: ["A1", "A2", "A3"]) { _ in }
        let window = UIWindow(windowScene: windowsScene)
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
    }
}


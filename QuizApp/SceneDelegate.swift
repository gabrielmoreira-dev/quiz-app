import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = scene as? UIWindowScene else { return }
        
        let viewController = ResultsViewController(
            summary: "A answer",
            answers: [
                PresentableAnswer(question: "Q1", correctAnswer: "A1", wrongAnswer: nil),
                PresentableAnswer(question: "Q2", correctAnswer: "A1", wrongAnswer: "A2")
            ]
        )
        let window = UIWindow(windowScene: windowsScene)
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
    }
}


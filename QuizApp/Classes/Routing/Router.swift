import GMQuizEngine
import UIKit

final class Router: Routing {
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactoring
    
    init(navigationController: UINavigationController, factory: ViewControllerFactoring) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: Question<String>, completion: @escaping ([String]) -> Void) {
        show(factory.makeQuestionViewController(for: question, completion: completion))
    }
    
    func routeTo(result: GameResult<Question<String>, [String]>) {
        show(factory.makeResultsViewController(for: result))
    }
}

private extension Router {
    func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}

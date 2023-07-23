import GMQuizEngine
import UIKit

protocol ViewControllerFactoring {
    func makeQuestionViewController(for question: Question<String>, completion: @escaping (String) -> Void) -> UIViewController
    func makeResultsViewController(for result: GameResult<Question<String>, String>) -> UIViewController
}

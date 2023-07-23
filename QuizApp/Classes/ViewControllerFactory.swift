import GMQuizEngine
import UIKit

final class ViewControllerFactory: ViewControllerFactoring {
    private let options: [Question<String>: [String]]
    
    init(options: [Question<String>: [String]]) {
        self.options = options
    }
    
    func makeQuestionViewController(for question: Question<String>, completion: @escaping ([String]) -> Void) -> UIViewController {
        switch question {
        case .singleAnswer(let value):
            return QuestionViewController(question: value, options: options[question] ?? []) { _ in }
        default:
            return UIViewController()
        }
    }
    
    func makeResultsViewController(for result: GameResult<Question<String>, [String]>) -> UIViewController {
        UIViewController()
    }
}

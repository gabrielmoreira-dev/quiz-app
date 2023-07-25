import GMQuizEngine
import UIKit

final class ViewControllerFactory {
    private let questions: [Question<String>]
    private let options: [Question<String>: [String]]
    
    init(questions: [Question<String>], options: [Question<String>: [String]]) {
        self.questions = questions
        self.options = options
    }
}

extension ViewControllerFactory: ViewControllerFactoring {
    func makeQuestionViewController(
        for question: Question<String>,
        completion: @escaping ([String]) -> Void
    ) -> UIViewController {
        guard let options = self.options[question] else {
            fatalError("Could not find options fro question \(question)")
        }
        return makeQuestionViewController(for: question, options: options, completion: completion)
    }
    
    func makeResultsViewController(for result: GameResult<Question<String>, [String]>) -> UIViewController {
        UIViewController()
    }
}

private extension ViewControllerFactory {
    func makeQuestionViewController(
        for question: Question<String>,
        options: [String],
        completion: @escaping ([String]) -> Void
    ) -> UIViewController {
        switch question {
        case .singleAnswer(let value):
            return makeQuestionViewController(for: question, value: value, options: options, allowsMultipleSelection: false, completion: completion)
        case .multipleAnswer(let value):
            return makeQuestionViewController(for: question, value: value, options: options, allowsMultipleSelection: true, completion: completion)
        }
    }
    
    func makeQuestionViewController(
        for question: Question<String>,
        value: String,
        options: [String],
        allowsMultipleSelection: Bool,
        completion: @escaping ([String]) -> Void
    ) -> QuestionViewController {
        let presenter = QuestionPresenter(questions: questions, question: question)
        let viewController = QuestionViewController(question: value, options: options, selection: completion)
        viewController.title = presenter.title
        _ = viewController.view
        viewController.tableView.allowsMultipleSelection = allowsMultipleSelection
        return viewController
    }
}

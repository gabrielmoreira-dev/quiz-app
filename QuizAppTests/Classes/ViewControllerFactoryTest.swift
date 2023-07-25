@testable import QuizApp
import XCTest

final class ViewControllerFactoryTest: XCTestCase {
    private let singleAnswerQuestion = Question.singleAnswer("Q1")
    private let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    private lazy var questions = [singleAnswerQuestion, multipleAnswerQuestion]
    private let options = ["A1", "A2"]
    
    func test_questionViewController_singleAnswer_createsControllerWithTitle() {
        let presenter = QuestionPresenter(questions: questions, question: singleAnswerQuestion)
        
        let viewController = makeViewController(questions: questions, question: singleAnswerQuestion)
        
        XCTAssertEqual(viewController.title, presenter.title)
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithQuestion() {
        let viewController = makeViewController(question: singleAnswerQuestion)
        
        XCTAssertEqual(viewController.question, "Q1")
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        let viewController = makeViewController(question: singleAnswerQuestion, options: options)
        
        XCTAssertEqual(viewController.options, options)
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {
        let viewController = makeViewController(question: singleAnswerQuestion)
        _ = viewController.view
        
        XCTAssertFalse(viewController.tableView.allowsMultipleSelection)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithTitle() {
        let presenter = QuestionPresenter(questions: questions, question: multipleAnswerQuestion)
        
        let viewController = makeViewController(questions: questions, question: multipleAnswerQuestion)
        
        XCTAssertEqual(viewController.title, presenter.title)
    }
    
    func test_questionViewController_MultipleAnswer_createsControllerWithQuestion() {
        let viewController = makeViewController(question: multipleAnswerQuestion)
        
        XCTAssertEqual(viewController.question, "Q2")
    }
    
    func test_questionViewController_MultipleAnswer_createsControllerWithOptions() {
        let viewController = makeViewController(question: multipleAnswerQuestion, options: options)
        
        XCTAssertEqual(viewController.options, options)
    }
    
    func test_questionViewController_MultipleAnswer_createsControllerWithSingleSelection() {
        let viewController = makeViewController(question: multipleAnswerQuestion)
        _ = viewController.view
        
        XCTAssertTrue(viewController.tableView.allowsMultipleSelection)
    }
}

private extension ViewControllerFactoryTest {
    func makeSUT(questions: [Question<String>], options: [Question<String> : [String]]) -> ViewControllerFactory {
        ViewControllerFactory(questions: questions, options: options)
    }
    
    func makeViewController(
        questions: [Question<String>] = [],
        question: Question<String> = .singleAnswer(String()),
        options: [String] = [String()]
    ) -> QuestionViewController {
        let sut = makeSUT(questions: questions, options: [question: options])
        return sut.makeQuestionViewController(for: question) { _ in } as! QuestionViewController
    }
}

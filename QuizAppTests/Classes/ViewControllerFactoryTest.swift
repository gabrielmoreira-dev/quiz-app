@testable import QuizApp
import XCTest

final class ViewControllerFactoryTest: XCTestCase {
    private let q1 = Question.singleAnswer("Q1")
    private let a1 = ["A1"]
    
    func test_questionViewController_createsControllerWithQuestion() {
        let sut = ViewControllerFactory(options: [q1: a1])
        
        let viewController = sut.makeQuestionViewController(for: q1) { _ in } as? QuestionViewController
        
        XCTAssertEqual(viewController?.question, "Q1")
    }
    
    func test_questionViewController_createsControllerWithOptions() {
        let sut = ViewControllerFactory(options: [q1: a1])
        
        let viewController = sut.makeQuestionViewController(for: q1) { _ in } as? QuestionViewController
        
        XCTAssertEqual(viewController?.options, a1)
    }
}

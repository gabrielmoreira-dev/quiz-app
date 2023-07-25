@testable import QuizApp
import XCTest

final class QuestionPresenterTest: XCTestCase {
    private let q1 = Question.singleAnswer("Q1")
    private let q2 = Question.multipleAnswer("Q2")
    
    func test_titleForFirstQuestion_shouldFormatTitleForIndex() {
        let sut = QuestionPresenter(questions: [q1], question: q1)
        
        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func test_titleForSecondQuestion_shouldFormatTitleForIndex() {
        let sut = QuestionPresenter(questions: [q1, q2], question: q2)
        
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    func test_titleForUnexistentQuestion_shouldBeEmpty() {
        let sut = QuestionPresenter(questions: [], question: q1)
        
        XCTAssertEqual(sut.title, String())
    }
}

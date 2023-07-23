@testable import QuizApp
import XCTest

final class QuestionTest: XCTestCase {
    private let type = String()
    
    func test_hashValueSingleAnswer_ReturnsTypeHash() {
        let sut = Question.singleAnswer(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_hashValueMultipleAnswer_ReturnsTypeHash() {
        let sut = Question.multipleAnswer(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_singleAnswer_isEqual() {
        let q1 = Question.singleAnswer(type)
        let q2 = Question.singleAnswer(type)
        
        XCTAssertEqual(q1, q2)
    }
    
    func test_singleAnswer_isNotEqual() {
        let q1 = Question.singleAnswer(type)
        let q2 = Question.singleAnswer("Other string")
        
        XCTAssertNotEqual(q1, q2)
    }
    
    func test_multipleAnswer_isEqual() {
        let q1 = Question.multipleAnswer(type)
        let q2 = Question.multipleAnswer(type)
        
        XCTAssertEqual(q1, q2)
    }
    
    func test_multipleAnswer_isNotEqual() {
        let q1 = Question.multipleAnswer(type)
        let q2 = Question.multipleAnswer("Other string")
        
        XCTAssertNotEqual(q1, q2)
    }
}

@testable import GMQuizEngine
@testable import QuizApp
import XCTest

final class ResultsPresenterTest: XCTestCase {
    private let singleAnswerQuestion = Question.singleAnswer("Q1")
    private let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    
    func test_summaryWithTwoQuestionsAndScoreOne_shouldReturnSummary() {
        let questions = [singleAnswerQuestion, multipleAnswerQuestion]
        let answers = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A2", "A3"]]
        let result = GameResult(answers: answers, score: 1)
        
        let sut = ResultsPresenter(result: result, questions: questions, correctAnswers: [:])
        
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswersWithouQuestions_shouldBeEmpty() {
        let questions: [Question<String>] = []
        let answers: [Question<String>: [String]] = [:]
        let result = GameResult(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, questions: questions, correctAnswers: [:])
        
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }

    func test_presentableAnswersWithWrongSingleAnswer_shouldMapAnswers() {
        let questions = [singleAnswerQuestion]
        let answers = [singleAnswerQuestion: ["A1"]]
        let correctAnswers = [singleAnswerQuestion: ["A2"]]
        let result = GameResult(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.correctAnswer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer, "A1")
    }
    
    func test_presentableAnswersWithWrongMultipleAnswer_shouldMapAnswers() {
        let questions = [multipleAnswerQuestion]
        let answers = [multipleAnswerQuestion: ["A1", "A4"]]
        let correctAnswers = [multipleAnswerQuestion: ["A2", "A3"]]
        let result = GameResult(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.first?.correctAnswer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer, "A1, A4")
    }
    
    func test_presentableAnswersWithTwoQuestions_shouldMapOrderedAnswers() {
        let answers = [multipleAnswerQuestion: ["A2", "A3"], singleAnswerQuestion: ["A1"]]
        let correctAnswers = [multipleAnswerQuestion: ["A2", "A3"], singleAnswerQuestion: ["A1"]]
        let orderedQuestions = [singleAnswerQuestion, multipleAnswerQuestion]
        let result = GameResult(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, questions: orderedQuestions, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 2)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.correctAnswer, "A1")
        XCTAssertNil(sut.presentableAnswers.first?.wrongAnswer)
        XCTAssertEqual(sut.presentableAnswers.last?.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.last?.correctAnswer, "A2, A3")
        XCTAssertNil(sut.presentableAnswers.last?.wrongAnswer)
    }
}

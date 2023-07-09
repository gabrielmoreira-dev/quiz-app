import XCTest
@testable import QuizApp

final class ResultsViewControllerTest: XCTestCase {
    func test_whenViewDidLoad_shouldRenderSummary() {
        let summary = "A summary"
        let sut = makeSUT(summary: summary)
        
        XCTAssertEqual(sut.headerLabel.text, summary)
    }
    
    func test_whenViewDidLoadWithoutAnswers_ShouldNotRenderAnswers() {
        let sut = makeSUT(answers: [])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_whenViewDidLoadWithOneAnswer_ShouldRenderAnswer() {
        let sut = makeSUT(answers: [makeAnswer()])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_whenCorrectAnswer_shouldRenderQuestionAndAnswer() {
        let question = "Q1"
        let correctAnswer = "A1"
        let answer = makeAnswer(question: question, correctAnswer: correctAnswer)
        let sut = makeSUT(answers: [answer])
        
        let cell = sut.tableView.cell(for: 0) as? CorrectAnswerCell
        
        XCTAssertEqual(cell?.questionLabel.text, question)
        XCTAssertEqual(cell?.answerLabel.text, correctAnswer)
    }
    
    func test_whenWrongAnswer_shouldRenderQuestionAndAnswer() {
        let question = "Q1"
        let correctAnswer = "A1"
        let wrongAnswer = "A2"
        let answer = makeAnswer(question: question, correctAnswer: correctAnswer, wrongAnswer: wrongAnswer)
        let sut = makeSUT(answers: [answer])
        
        let cell = sut.tableView.cell(for: 0) as? WrongAnswerCell
        
        XCTAssertEqual(cell?.questionLabel.text, question)
        XCTAssertEqual(cell?.correctAnswerLabel.text, correctAnswer)
        XCTAssertEqual(cell?.wrongAnswerLabel.text, wrongAnswer)
    }
}

private extension ResultsViewControllerTest {
    func makeSUT(summary: String = String(), answers: [PresentableAnswer] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    func makeAnswer(question: String = String(), correctAnswer: String = String(), wrongAnswer: String? = nil) -> PresentableAnswer {
        PresentableAnswer(question: question, correctAnswer: correctAnswer, wrongAnswer: wrongAnswer)
    }
}

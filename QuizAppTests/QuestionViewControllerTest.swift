import XCTest
@testable import QuizApp

final class QuestionViewControllerTest: XCTestCase {
    func test_viewDidLoad_renderQuestionHeaderText() {
        let sut = makeSUT(question: "Q1")
        
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withNoOptions_rendersZeroOptions() {
        let sut = makeSUT(options: [])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_withOneOption_rendersOneOption() {
        let sut = makeSUT(options: ["A1"])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withOneOption_rendersOneOptionText() {
        let sut = makeSUT(options: ["A1"])
        
        XCTAssertEqual(sut.tableView.title(for: 0), "A1")
    }
    
    func test_optionSelected_withSinlgeSelection_notifiesDelegate() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1"]) { receivedAnswer = $0 }
        
        sut.tableView.select(row: 0)
        
        XCTAssertEqual(receivedAnswer, ["A1"])
    }
    
    func test_optionDeselected_withSinlgeSelection_doesNotNotifiesDelegate() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1"]) { receivedAnswer = $0 }
        
        sut.tableView.select(row: 0)
        sut.tableView.deselect(row: 0)
        
        XCTAssertEqual(receivedAnswer, ["A1"])
    }
    
    func test_optionSelected_withTwoOptions_notifiesDelegateWithLastSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        
        sut.tableView.select(row: 0)
        sut.tableView.select(row: 1)
        
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    func test_optionSelected_withMultipleSelectionEnabled_notifiesDelegateSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        
        sut.tableView.allowsMultipleSelection = true
        sut.tableView.select(row: 0)
        sut.tableView.select(row: 1)
        
        XCTAssertEqual(receivedAnswer, ["A1", "A2"])
    }
    
    func test_optionDeselected_withMultipleSelectionEnabled_notifiesDelegate() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        
        sut.tableView.allowsMultipleSelection = true
        sut.tableView.select(row: 0)
        sut.tableView.deselect(row: 0)
        
        XCTAssertEqual(receivedAnswer, [])
    }
}

private extension QuestionViewControllerTest {
    func makeSUT(
        question: String = "",
        options: [String] = [],
        selection: @escaping ([String]) -> Void = { _ in }
    ) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        _ = sut.view
        return sut
    }
}

private extension UITableView {
    func cell(for row: Int, at section: Int = 0) -> UITableViewCell? {
        dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: section))
    }
    
    func title(for row: Int, at section: Int = 0) -> String? {
        cell(for: row, at: section)?.textLabel?.text
    }
    
    func select(row: Int, at section: Int = 0) {
        let indexPath = IndexPath(row: row, section: section)
        selectRow(at: indexPath, animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: indexPath)
    }
    
    func deselect(row: Int, at section: Int = 0) {
        let indexPath = IndexPath(row: row, section: section)
        deselectRow(at: indexPath, animated: false)
        delegate?.tableView?(self, didDeselectRowAt: indexPath)
    }
}

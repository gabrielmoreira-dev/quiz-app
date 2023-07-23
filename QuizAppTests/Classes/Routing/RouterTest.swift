import XCTest
@testable import GMQuizEngine
@testable import QuizApp

final class RouterTest: XCTestCase {
    private let q1: Question = .singleAnswer("Q1")
    private let q2: Question = .singleAnswer("Q2")
    private lazy var r1 = GameResult(answers: [q1: ["A1"]], score: 10)
    private lazy var r2 = GameResult(answers: [q2: ["A2"]], score: 10)
    private let navigationController = UINavigationControllerStub()
    private let factory = ViewControllerFactoryStub()
    private lazy var sut = Router(navigationController: navigationController, factory: factory)
    
    func test_routeToSecondQuestion_showsQuestionController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: q1, with: viewController)
        factory.stub(question: q2, with: secondViewController)
        
        sut.routeTo(question: q1) { _ in }
        sut.routeTo(question: q2) { _ in }
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToQuestion_showsQuestionControllerWithRightCallback() {
        var callbackWasFired = false
        
        sut.routeTo(question: q1) { _ in callbackWasFired = true }
        factory.answerCompletions[q1]?([""])
        
        XCTAssert(callbackWasFired)
    }
    
    func test_RouteToResult_showsResultController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(result: r1, with: viewController)
        factory.stub(result: r2, with: secondViewController)
        
        sut.routeTo(result: r1)
        sut.routeTo(result: r2)
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
}

private final class ViewControllerFactoryStub: ViewControllerFactoring {
    private var stubbedQuestions = [Question<String>: UIViewController]()
    private var stubbedResults = [GameResult<Question<String>, [String]>: UIViewController]()
    private(set) var answerCompletions = [Question<String>: ([String]) -> Void]()
    
    func stub(question: Question<String>, with viewController: UIViewController) {
        stubbedQuestions[question] = viewController
    }
    
    func stub(result: GameResult<Question<String>, [String]>, with viewController: UIViewController) {
        stubbedResults[result] = viewController
    }
    
    func makeQuestionViewController(for question: Question<String>, completion: @escaping ([String]) -> Void) -> UIViewController {
        answerCompletions[question] = completion
        return stubbedQuestions[question] ?? UIViewController()
    }
    
    func makeResultsViewController(for result: GameResult<Question<String>, [String]>) -> UIViewController {
        stubbedResults[result] ?? UIViewController()
    }
}

extension GameResult: Hashable {
    public func hash(into hasher: inout Hasher) {}
}

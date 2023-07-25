import GMQuizEngine

final class ResultsPresenter {
    private let result: GameResult<Question<String>, [String]>
    private let questions: [Question<String>]
    private let correctAnswers: [Question<String>: [String]]
    
    init(
        result: GameResult<Question<String>, [String]>,
        questions: [Question<String>],
        correctAnswers: [Question<String>: [String]]
    ) {
        self.result = result
        self.questions = questions
        self.correctAnswers = correctAnswers
    }
    
    var summary: String {
        "You got \(result.score)/\(result.answers.count) correct"
    }
    
    var presentableAnswers: [PresentableAnswer] {
        questions.map { question in
            guard let userAnswer = result.answers[question],
                  let correctAnswer = correctAnswers[question] else {
                fatalError("Could not find correct answer for question: \(question)")
            }
            return getPresentableAnswer(for: question, userAnswer: userAnswer, correctAnswer: correctAnswer)
        }
    }
}

private extension ResultsPresenter {
    func getPresentableAnswer(
        for question: Question<String>,
        userAnswer: [String],
        correctAnswer: [String]
    ) -> PresentableAnswer {
        switch question {
        case .singleAnswer(let value), .multipleAnswer(let value):
            return PresentableAnswer(
                question: value,
                correctAnswer: getFormattedAnswer(correctAnswer),
                wrongAnswer: getFormattedWrongAnswer(userAnswer: userAnswer, correctAnswer: correctAnswer)
            )
        }
    }
    
    func getFormattedWrongAnswer(userAnswer: [String], correctAnswer: [String]) -> String? {
        return correctAnswer == userAnswer ? nil : getFormattedAnswer(userAnswer)
    }
    
    func getFormattedAnswer(_ answer: [String]) -> String {
        answer.joined(separator: ", ")
    }
}

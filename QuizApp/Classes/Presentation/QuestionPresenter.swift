final class QuestionPresenter {
    private let questions: [Question<String>]
    private let question: Question<String>
    
    init(questions: [Question<String>], question: Question<String>) {
        self.questions = questions
        self.question = question
    }
    
    var title: String {
        guard let index = questions.firstIndex(where: { $0 == question }) else {
            return String()
        }
        return "Question #\(index + 1)"
    }
}

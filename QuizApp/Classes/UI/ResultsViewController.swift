import UIKit

final class ResultsViewController: UIViewController {
    private let summary: String
    private let answers: [PresentableAnswer]
    
    private(set) lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CorrectAnswerCell.self)
        tableView.register(WrongAnswerCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    init(summary: String, answers: [PresentableAnswer] = []) {
        self.summary = summary
        self.answers = answers
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        if answer.wrongAnswer == nil {
            return correctAnswerCell(for: answer)
        }
        return wrongAnswerCell(for: answer)
    }
    
    private func correctAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CorrectAnswerCell.self)
        cell?.setup(with: answer.question, and: answer.correctAnswer)
        return cell ?? UITableViewCell()
    }
    
    private func wrongAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(WrongAnswerCell.self)
        cell?.setup(with: answer.question, answer.correctAnswer, and: answer.wrongAnswer ?? String())
        return cell ?? UITableViewCell()
    }
}

extension ResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        answers[indexPath.row].wrongAnswer != nil ? 100 : 80
    }
}

extension ResultsViewController: ViewConfiguration {
    func setupHierarchy() {
        view.addSubview(headerLabel)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
        ])
    }
    
    func setupViews() {
        view.backgroundColor = .white
        headerLabel.text = summary
    }
}

import UIKit

final class CorrectAnswerCell: UITableViewCell {
    private(set) lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setup(with question: String, and answer: String) {
        questionLabel.text = question
        answerLabel.text = answer
        setupLayout()
    }
}

extension CorrectAnswerCell: ViewConfiguration {
    func setupHierarchy() {
        contentView.addSubview(questionLabel)
        contentView.addSubview(answerLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            answerLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 12),
            answerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            answerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            answerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func setupViews() {
        contentView.backgroundColor = .white
    }
}

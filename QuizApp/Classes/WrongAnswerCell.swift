import UIKit

final class WrongAnswerCell: UITableViewCell {
    private(set) lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var correctAnswerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var wrongAnswerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setup(with question: String, _ answer: String, and wrongAnswer: String) {
        questionLabel.text = question
        correctAnswerLabel.text = answer
        wrongAnswerLabel.text = wrongAnswer
        setupLayout()
    }
}

extension WrongAnswerCell: ViewConfiguration {
    func setupHierarchy() {
        contentView.addSubview(questionLabel)
        contentView.addSubview(correctAnswerLabel)
        contentView.addSubview(wrongAnswerLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            correctAnswerLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 8),
            correctAnswerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            correctAnswerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            wrongAnswerLabel.topAnchor.constraint(equalTo: correctAnswerLabel.bottomAnchor, constant: 8),
            wrongAnswerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            wrongAnswerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            wrongAnswerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func setupViews() {
        contentView.backgroundColor = .white
    }
}


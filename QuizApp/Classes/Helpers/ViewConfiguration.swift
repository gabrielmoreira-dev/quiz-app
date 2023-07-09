protocol ViewConfiguration {
    func setupLayout()
    func setupHierarchy()
    func setupConstraints()
    func setupViews()
}

extension ViewConfiguration {
    func setupLayout() {
        setupHierarchy()
        setupConstraints()
        setupViews()
    }
}

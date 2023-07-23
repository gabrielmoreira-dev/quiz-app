import UIKit

extension UITableView {
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

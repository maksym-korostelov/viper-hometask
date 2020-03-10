import UIKit

class ListTableViewController: UIViewController, ListViewProtocol {
    @IBOutlet weak var dataListTableView: UITableView!
    
    var presenter: ListPresenterProtocol!
    var configurator: ListConfiguratorProtocol = ListConfigurator()

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        dataListTableView.tableFooterView = UIView()
        presenter.notifyViewLoaded()
    }
    
    func reloadData() {
        dataListTableView.reloadData()
    }
}

extension ListTableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOrItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let listCell = tableView.dequeueReusableCell(withIdentifier: "dataReuseIdentifier") else { fatalError() }
        
        listCell.textLabel?.text = presenter.item(at: indexPath)
        
        return listCell
    }
}

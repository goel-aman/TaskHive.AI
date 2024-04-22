//
//  ViewController.swift
//  Hive.Ai.Task
//
//  Created by aman on 15/04/24.
//

import UIKit

class ViewController: UIViewController, DataServices {

    let dataViewModel = DataViewModel()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        dataViewModel.fetchData("")
        dataViewModel.dataDelegate = self
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataViewModel.fetchData(searchText)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.data.query.pages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let page = Array(self.dataViewModel.data.query.pages.values)[indexPath.row]
        cell.cellTitle.text = page.title
        
        if page.thumbnail != nil {
            let url = URL(string: page.thumbnail!.source)!
            cell.imageView?.load(url: url)
        }
        
        cell.cellDescription.text = page.extract
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// improve loading of images......
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}



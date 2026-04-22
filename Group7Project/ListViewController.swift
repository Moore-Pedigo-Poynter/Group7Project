//
//  ListViewController.swift
//  Group7Project
//
//  Created by Pedigo, Charles L. on 4/21/26.
//

import UIKit

//source, destination
class ListViewController: UIViewController {
    
    @IBOutlet weak var passwordTableView: UITableView!
    
    var passwordList = [String]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? PassViewController {
            vc.listVC = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = passwordList[indexPath.row]
        
        return cell
    }
    
    
}


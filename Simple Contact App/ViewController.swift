//
//  ViewController.swift
//  Simple Contact App
//
//  Created by user225247 on 11/11/22.
//

//I want a new comment to BE SURE that's everything works for me

import UIKit

class ViewController: UIViewController {
    
    let names = [
    "John Smith",
    "Dan Smith",
    "Jason Smith",
    "Ann Smith"
    ]
    
    //create IBOutlet for a tableview
    @IBOutlet var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // some data
        
        //tableview initialization -- start
        tableView.delegate = self
        tableView.dataSource = self
        //tableview initialization -- end
    }

    

}

extension ViewController: UITableViewDelegate{
    //This function handle interactions with cells
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("you tapped me!")
    }
    
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //say how much rows you need to show
        //add something new
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Returns a reusable table-view cell object after locating it by its identifier.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
}

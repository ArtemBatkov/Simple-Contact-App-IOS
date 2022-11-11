//
//  ViewController.swift
//  Simple Contact App
//
//  Created by user225247 on 11/11/22.
//

//I want a new comment to BE SURE that's everything works for me

import UIKit
import Fakery

class ViewController: UIViewController {
    
    //Contains contacts' names
    var names = [String]()
    let faker: Faker = Faker()
    
    //Contains section title
    var sectionTitle = [String]()
    
    //Contains key and contact array
    var ContactsDict = [String: [String]]()
    
    //create IBOutlet for a tableview
    @IBOutlet var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // some data
        
        //call fake data contacts -- start
        InitializeContacts()
        //call fake data contacts -- end
        
        
        //tableview initialization -- start
        tableView.delegate = self
        tableView.dataSource = self
        //tableview initialization -- end
        
        //sectionTitle -- start
        sectionTitle = Array(Set(names.compactMap({String($0.prefix(1))})))
        sectionTitle.sort()
        sectionTitle.forEach({ContactsDict[$0] = [String]()})//it will create blank array
        names.forEach({ContactsDict[String($0.prefix(1))]?.append($0)})
        //sectionTitle -- end
        
    }
    
    func InitializeContacts(){
        //this function creates fake contacts
        for i in 0...99{
            names.append((faker.name.firstName() + "  " + faker.name.lastName()))
        }
    }
   
    

}

extension ViewController: UITableViewDelegate{
    //This function handle interactions with cells
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitle.count
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("you tapped me!")
    }
    
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //say how much rows you need to show
        //add something new
        ContactsDict[sectionTitle[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Returns a reusable table-view cell object after locating it by its identifier.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ContactsDict[sectionTitle[indexPath.section]]?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitle[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitle
    }
}

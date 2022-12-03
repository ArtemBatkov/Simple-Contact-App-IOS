//
//  ViewController.swift
//  Simple Contact App
//
//  Created by user225247 on 11/11/22.
//

//I want a new comment to BE SURE that's everything works for me

import UIKit
import Fakery
import RealmSwift

struct  Contact{
    var FullName: String
    var Telephone: String
}

class Person: Object{
    @objc dynamic var fullName: String = ""
    @objc dynamic var telephone: String =   ""
}

class ViewController: UIViewController {
    
    let realm = try! Realm()
    
    
    var contacts = [Contact]()
    
    //Contains contacts' names
    var names = [String]()
    let faker: Faker = Faker()
    
    //Contains section title
    var sectionTitle = [String]()
    
    //Contains key and contact array
    var ContactsDict = [String: [String]]()
    
    var PhoneNumbers = [String]()
    
    var completionHandler: (([String: [String]]) -> Void)?
    
    //create IBOutlet for a tableview
    @IBOutlet var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // some data
        
        //call fake data contacts -- start
//        InitializeContacts()
        //call fake data contacts -- end
        
        //tableview initialization -- start
        tableView.delegate = self
        tableView.dataSource = self
        //tableview initialization -- end
        
        //sectionTitle -- start
//        sectionTitle = Array(Set(names.compactMap({String($0.prefix(1))})))
//        sectionTitle.sort()
//        sectionTitle.forEach({ContactsDict[$0] = [String]()})//it will create blank array
//        names.forEach({ContactsDict[String($0.prefix(1))]?.append($0)})
        //sectionTitle -- end
        
        
        //hardcoding -- start
        contacts.append(Contact(FullName: "Artem Slonko", Telephone: "12345678"))
        contacts.append(Contact(FullName: "Vasya ysa", Telephone: "000000000"))
        contacts.append(Contact(FullName: "Gosha dudar", Telephone: "90909022222"))
        //hardcoding -- end
        
        render()
       
        
    }
    
    func InitializeContacts(){
        //this function creates fake contacts
        for i in 0...99{
            names.append((faker.name.firstName() + "  " + faker.name.lastName() + " phone: " + faker.phoneNumber.cellPhone()))
        }
    }
    
    func render(){
        let people = realm.objects(Person.self)
        for person in people{
            let fullName = person.fullName
            let telephone = person.telephone
            let contact = Contact(FullName: fullName, Telephone: telephone)
            contacts.append(contact)
        }
        
    }
    
    
    public func SaveData(){
        let joe = Person()
        joe.fullName = "Joe Smith"
        joe.telephone = "1111111111111"
        realm.beginWrite()
        realm.add(joe)
        try! realm.commitWrite()
    }
   
//    func DeleteContact(_contact_name: String, _indexPath:IndexPath){
//        let first_letter = String(_contact_name.prefix(1))
//        ContactsDict.removeValue(forKey: first_letter)
//        if(tableView != nil){
//            tableView.deleteRows(at: [_indexPath], with: .fade)
//            tableView.reloadData()
//        }
//    }
    
    
    
    @IBAction func AddContactButton(_ sender: UIBarButtonItem) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "AddContactViewController") as? AddContactViewController{
            let controller = AddContactViewController()
            controller.delegateAdd = self
            vc.delegateAdd = controller.delegateAdd
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
}

extension ViewController: UITableViewDelegate{
    //This function handle interactions with cells
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        sectionTitle.count
//    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "CellUIViewController") as? CellUIViewController{
//            self.present(UINavigationController(rootViewController: CellUIViewController()), animated: true, completion: nil)
            
            
            
                            //            let SectionName = sectionTitle[indexPath.section]
//            var ContactsInSection =  ContactsDict[SectionName]
//            ContactsInSection?.sorted()
//
//            vc.ContactPhone = String(ContactsInSection![indexPath.row].split(separator: "phone:")[1])
//            //"todo phone        section #\(indexPath.section)  row# \(indexPath.row)"
//            vc.ContactName = ContactsInSection![indexPath.row].components(separatedBy: "phone")[0]
//
//            completionHandler?(ContactsDict)
//            present(vc,animated: true)
            
            let controller = CellUIViewController()
            controller.delegate = self
            controller.delegateCancel = self
//            controller.phone = contacts[indexPath.row].Telephone
//            controller.fullname = contacts[indexPath.row].FullName
            
            vc.fullname = contacts[indexPath.row].FullName
            vc.phone = contacts[indexPath.row].Telephone
            vc.delegate = controller.delegate
            vc.indexPath = indexPath
            vc.delegateCancel =  controller.delegateCancel
            self.navigationController?.pushViewController(vc, animated: true)
        }
        print("you tapped me")
    }
   
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //say how much rows you need to show
        //add something new
//        ContactsDict[sectionTitle[section]]?.count ?? 0
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Returns a reusable table-view cell object after locating it by its identifier.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        var string = ContactsDict[sectionTitle[indexPath.section]]?[indexPath.row]
        cell.textLabel?.text = contacts[indexPath.row].FullName //string?.components(separatedBy: "phone")[0]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        sectionTitle[section]
//    }
//    
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        sectionTitle
//    }
}

extension ViewController: DeleteContactDelegate{
    func deleteContact(contact: Contact, indexPath: IndexPath) {
        self.dismiss(animated: true){
            for i in 0...self.contacts.count{
                if((self.contacts[i].FullName == contact.FullName) && (self.contacts[i].Telephone == contact.Telephone)){
                    self.contacts.remove(at: i)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                    break
                }
            }
        }
    }
}


extension ViewController: CancelDelegate{
    func cancelAndsaveChanges(contact: Contact, indexPath: IndexPath) {
        self.dismiss(animated: true){
            self.contacts[indexPath.row].FullName = contact.FullName
            self.contacts[indexPath.row].Telephone = contact.Telephone
        }
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
    }
}



extension ViewController: AddContactDelegate{
    func addContact(contact: Contact) {
        self.dismiss(animated: true){
            self.contacts.append(contact)
        }
        let indexPath = IndexPath(row: contacts.count-1, section: 0)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
    }
}

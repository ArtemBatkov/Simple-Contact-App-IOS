//
//  ViewController.swift
//  Simple Contact App
//
//  Created by user225247 on 11/11/22.
//

//I want a new comment to BE SURE that's everything works for me

import UIKit



class ViewController: UIViewController {
    
    private let keyContactsData = "CONTACTS_DATA"
    
    var contactURL: URL = {
        let documentDirectiories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let document = documentDirectiories.first!
        return document.appendingPathComponent("contact.archive")
    }()
    
    var contactListObject = ContactList()
    
    var completionHandler: (([String: [String]]) -> Void)?
    
    //create IBOutlet for a tableview
    @IBOutlet var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        do{
            let data = try Data(contentsOf: contactURL)
            contactListObject.LoadContacts(_loadedContacts: try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Contact])
            
        }catch let e {
            print("couldn't archive due to this error: \(e)")
        }
    }
    
    func Save(){
        do{
            let archiveData = try NSKeyedArchiver.archivedData(withRootObject: contactListObject.getContactList(), requiringSecureCoding: false)
            try archiveData.write(to: contactURL)
        } catch let e{
            print("was not ebale to archive due to this error: \(e)")
        }
    }
    
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
        Save()
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
}

extension ViewController: UITableViewDelegate{
    //This function handle interactions with cells
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "CellUIViewController") as? CellUIViewController{
            let controller = CellUIViewController()
            controller.delegate = self
            controller.delegateCancel = self
            let cellContact = contactListObject.getContact(_position: indexPath.row)
            if cellContact != nil {
                vc.fullname = cellContact!.getFullName()
                vc.phone = cellContact!.getTelephone()
                vc.delegate = controller.delegate
                vc.indexPath = indexPath
                vc.delegateCancel =  controller.delegateCancel
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
   
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactListObject.getContactList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Returns a reusable table-view cell object after locating it by its identifier.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellContact = contactListObject.getContact(_position: indexPath.row)
        if(cellContact != nil){
            cell.textLabel?.text = cellContact!.getFullName()
        }
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
            let position = self.contactListObject.DeleteContact(_contact: contact)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
            }
        }
}



extension ViewController: CancelDelegate{
    func cancelAndsaveChanges(contact: Contact, indexPath: IndexPath) {
        self.dismiss(animated: true){
            self.contactListObject.EditContact(_newcontact: contact, _position: indexPath.row)
        }
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
    }
}



extension ViewController: AddContactDelegate{
    func addContact(contact: Contact) {
        self.dismiss(animated: true){
            self.contactListObject.AddContact(_contact: contact)
        }
        let indexPath = IndexPath(row: contactListObject.getContactList().count-1,section: 0)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
    }
}

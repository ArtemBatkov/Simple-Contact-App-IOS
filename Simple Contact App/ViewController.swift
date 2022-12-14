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
    
    var sectionTitle = [String]()
    
    var ContactsDictionary = [String: [Contact]]()
    
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
        CreatSectionTitle()
        CreateDictionary()
    }
    
    func CreatSectionTitle(){
        sectionTitle.removeAll()
        var contacts = contactListObject.getContactList()
        var size = contacts.count
        if(size>0){
            var firstLetter: String
            var Name: String
            for i in 0...size-1{
                Name = contacts[i].getName()
                firstLetter = Name.substring(to: Name.index(Name.startIndex, offsetBy: 1)).uppercased()
                if(!sectionTitle.contains(firstLetter)){
                    //if there is no the first letter in the sectionTitle
                    sectionTitle.append(firstLetter)
                }
            }
            sectionTitle.sort()
        }
    }
    
    func CreateDictionary(){
        ContactsDictionary.removeAll()
        sectionTitle.forEach({ContactsDictionary[$0] = [Contact]()})
        var sizeTitle = sectionTitle.count
        if(sizeTitle>0){
            let contacts = contactListObject.getContactList()
            var contactSize = contacts.count
            var firstLetter: String
            var Name: String
            var contact: Contact
            for i in 0...sizeTitle-1{
                for j in 0...contactSize-1{
                    Name = contacts[j].getName()
                    firstLetter = Name.substring(to: Name.index(Name.startIndex, offsetBy: 1)).uppercased()
            
                    if(firstLetter == sectionTitle[i]){
                        contact = contactListObject.getContact(_position: j)!
                        ContactsDictionary[sectionTitle[i]]?.append(contact)
                    }
                }
                
            }
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
            let cellContact = ContactsDictionary[sectionTitle[indexPath.section]]?[indexPath.row]
            if cellContact != nil {
                vc.name = cellContact!.getName()
                vc.surname = cellContact!.getSurname()
                vc.phone = cellContact!.getTelephone()
                vc.birthdate = cellContact!.getBirthDate()
                vc.description_ = cellContact!.getDescription()
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
//        return contactListObject.getContactList().count
        return ContactsDictionary[sectionTitle[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Returns a reusable table-view cell object after locating it by its identifier.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellContact = contactListObject.getContact(_position: indexPath.row)
        if(cellContact != nil){
//            cell.textLabel?.text = cellContact!.getFullName()
            cell.textLabel?.text = "\(ContactsDictionary[sectionTitle[indexPath.section]]![indexPath.row].getName()) \(ContactsDictionary[sectionTitle[indexPath.section]]![indexPath.row].getSurname())"
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitle[section]
    }
   
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitle
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
}

extension ViewController: DeleteContactDelegate{
    func deleteContact(contact: Contact, indexPath: IndexPath) {
        self.dismiss(animated: true){
            self.ContactsDictionary[self.sectionTitle[indexPath.section]]?.remove(at: indexPath.row) //delete in the dictionary first
            self.contactListObject.DeleteContact(_contact: contact) // delete from model
            self.CreatSectionTitle()
            self.CreateDictionary()
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            if(self.tableView.numberOfRows(inSection: indexPath.section)-1 <= 0){
                self.tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            }
            self.tableView.endUpdates()
        }
    }
}



extension ViewController: CancelDelegate{
    func cancelAndsaveChanges(contact: Contact, indexPath: IndexPath) {
        self.dismiss(animated: true){
            let oldContact = self.ContactsDictionary[self.sectionTitle[indexPath.section]]?[indexPath.row]
            let oldContactPosition = self.contactListObject.getPosition(_contact: oldContact!)
            if(oldContactPosition != -1){
                self.contactListObject.EditContact(_newcontact: contact, _position: oldContactPosition)
                var oldDictionary = self.ContactsDictionary[self.sectionTitle[indexPath.section]]?[indexPath.row]
                oldDictionary?.setName(_newName: contact.getName())
                oldDictionary?.setSurname(_newSurname: contact.getSurname())
                oldDictionary?.setTelephone(_newTelephone: contact.getTelephone())
                oldDictionary?.setDescription(_newDescription: contact.getDescription())
                oldDictionary?.setBirthDate(_newBirthDate: contact.getBirthDate())
            }else{return}
            self.CreatSectionTitle()
            self.CreateDictionary()
            self.tableView.beginUpdates()
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }
}



extension ViewController: AddContactDelegate{
    func addContact(contact: Contact) {
        self.dismiss(animated: true){
            let Name = contact.getName() // get contact full name
            let firstLetter = Name.substring(to: Name.index(Name.startIndex, offsetBy: 1)).uppercased()// get first letter of the name
            self.contactListObject.AddContact(_contact: contact)//add contact to model
            self.CreatSectionTitle()//create title
            self.CreateDictionary()//create dictionary
            
            var section = 0
            var indexPath = IndexPath()
            var row = 0
            self.tableView.beginUpdates()
            if (self.sectionTitle.count - self.tableView.numberOfSections == 1){
                //sectionTitle is bigger than numberOfSection by 1
                section = (self.tableView.numberOfSections - 1 < 0) ? 0 : Int(self.sectionTitle.firstIndex(of: firstLetter) ?? -1)
                if (section == -1) {return}
                let indexSet = IndexSet(integer: section)
                self.tableView.insertSections(indexSet, with: .automatic)
            }
            else if (self.sectionTitle.count - self.tableView.numberOfSections == 0){
                //sectionTitle length the same as numberOfSection
                section = Int(self.sectionTitle.firstIndex(of: firstLetter) ?? -1)
                if(section == -1){return}
                row = self.tableView.numberOfRows(inSection: section)
                indexPath = IndexPath(row: row,section: section)
                self.tableView.insertRows(at: [indexPath], with: .automatic)
            }
            self.tableView.endUpdates()
        }
    }
}



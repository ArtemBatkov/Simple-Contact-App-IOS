//
//  Contact.swift
//  Simple Contact App
//
//  Created by user225247 on 12/10/22.
//

import Foundation

class  Contact : NSObject, NSCoding{
    private var Name: String = ""
    private var Telephone: String = ""
    private var Surname: String = ""
    private var Description: String = ""
    private var BirthDate: String = ""
    
    init(_Name:String, _Surname: String, _Telephone:String, _BirthDate:String ,_Description: String ) {
        self.Name = _Name
        self.Surname = _Surname
        self.Telephone = _Telephone
        self.BirthDate = _BirthDate
        self.Description = _Description
    }
    
    
    
    func getName()->String{return self.Name}
    func getSurname()->String{return self.Surname}
    func getTelephone()->String{return self.Telephone}
    func getBirthDate()->String{return self.BirthDate}
    func getDescription()->String{return self.Description}
    
    func setName(_newName: String){self.Name = _newName}
    func setSurname(_newSurname: String){self.Surname = _newSurname}
    func setTelephone(_newTelephone: String){self.Telephone = _newTelephone}
    func setBirthDate(_newBirthDate: String){self.BirthDate = _newBirthDate}
    func setDescription(_newDescription: String){self.Description = _newDescription}
    
    func encode(with coder: NSCoder) {
        coder.encode(self.Name,forKey: "Name")
        coder.encode(self.Surname, forKey: "Surname")
        coder.encode(self.Telephone, forKey: "Telephone")
        coder.encode(self.BirthDate, forKey: "BirthDay")
        coder.encode(self.Description, forKey: "Description")
    }
    
    required init?(coder: NSCoder) {
        self.Name = coder.decodeObject(forKey: "Name") as! String
        self.Surname = coder.decodeObject(forKey: "Surname") as! String
        self.Telephone =  coder.decodeObject(forKey: "Telephone") as! String
        self.BirthDate = coder.decodeObject(forKey: "BirthDay") as! String
        self.Description = coder.decodeObject(forKey: "Description") as! String
        super.init()
    }
}

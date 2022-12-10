//
//  Contact.swift
//  Simple Contact App
//
//  Created by user225247 on 12/10/22.
//

import Foundation

class  Contact : NSObject, NSCoding{
    private var FullName: String = ""
    private var Telephone: String = ""
    
    init(_FullName:String,_Telephone:String) {
        self.FullName = _FullName
        self.Telephone = _Telephone
    }
    
    func getFullName()->String{return self.FullName}
    func getTelephone()->String{return self.Telephone}
    func setFullName(_newName: String){self.FullName = _newName}
    func setTelephone(_newTelephone: String){self.Telephone = _newTelephone}
    
    func encode(with coder: NSCoder) {
        coder.encode(self.FullName,forKey: "FullName")
        coder.encode(self.Telephone, forKey: "Telephone")
    }
    
    required init?(coder: NSCoder) {
        FullName = coder.decodeObject(forKey: "FullName") as! String
        Telephone = coder.decodeObject(forKey: "Telephone") as! String
        super.init()
    }
}

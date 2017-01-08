//
//  Professor.swift
//  ColmeiaApp
//
//  Created by Lynneker Souza on 1/8/17.
//  Copyright © 2017 Lynneker Souza. All rights reserved.
//

import UIKit
import Parse

class Professor: NSObject {
    
    var ob​jectId: String!
    var name: String!
    var picture: UIImage!
    var curriculum: String!
    var subject: String!
    var grade: Double!
    
    override init() {
        super.init()
    }
    
    init(id: String, name: String, picture: UIImage,curriculum:String, subject: String, grade: Double ) {
        super.init()

        self.ob​jectId = id
        self.name = name
        self.picture = picture
        self.curriculum = curriculum
        self.subject = subject
        self.grade = grade
        
    }
    
    init(professor: PFObject!) {
        super.init()
        
        self.ob​jectId = professor.objectId!
        self.name = professor["nome"] as! String!
        self.picture = UIImage(named: "prof.png")
        self.curriculum = professor["curriculo"] as! String!
        self.subject = professor["materia"] as! String!
        self.grade = professor["nota"] as! Double!
    
    }
    
    override var description: String {
        return "Id: \(self.ob​jectId!)\nNome:\(self.name!)\n"
    }
}

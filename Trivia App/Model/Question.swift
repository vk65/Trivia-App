//
//  Quetsion.swift
//  Trivia App
//
//  Created by Cheripelly tirumala on 16/04/21.
//

import Foundation



struct Questions: Codable {



        let question : String?
        let answers : Answer?

        



  

}



struct Answer : Codable {



        let a : String?

        let b : String?

        let c : String?
    
        let d : String?

        let correct : String?



       



}



struct AnswerDetails{

    var a : String

    var b: String

    var c: String
    
    var d : String?

    var correct : String

}

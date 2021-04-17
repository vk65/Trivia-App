//
//  NextViewController.swift
//  Trivia App
//
//  Created by Cheripelly tirumala on 16/04/21.
//

import UIKit
//importing a sqlite framework for storing the data
import SQLite

//creating a instance of class viewcontroller through a variable

var detailsArr:[Details] = []
class NextViewController: UIViewController {
    
    //creating a instance of questions and answers and buttons a variable
    @IBOutlet weak var questionLbl: UILabel!
    
    
    @IBOutlet weak var choice1: UIButton!
    
    
    @IBOutlet weak var choice2: UIButton!
    
    
    @IBOutlet weak var choice3: UIButton!
    
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var choice4: UIButton!
    @IBOutlet weak var lbl1: UILabel!
    
    
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var lbl3: UILabel!
    
    
    @IBOutlet weak var lbl4: UILabel!
    
    
    @IBOutlet weak var PerviousBtn: UIButton!
    
    
    @IBOutlet weak var NextBtn: UIButton!
    
    
    @IBOutlet weak var showSave: UIButton!
    
    @IBOutlet weak var save: UIButton!
    var data:[Questions]!
//creating a connection variable in sqllite
        var dbc:Connection!
        var questionsArr:[String] = []

        var questionNo:Int = 0

        @objc var score:Int = 0

        var answerArr:[AnswerDetails] = []

        var answerDetailsArr:[Answer] = []
        
        var selectedAnswer = ""
    
    var userObj = Details()
    
        var dateTimeString:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //clearing the backbutton in navigation bar
        navigationItem.hidesBackButton = true
        //making the save button on hide
        save.isHidden = true
      
//calling the function
        parseJson()
        answerDetails()
        updateUI()
        createDBConnection()
        createTable()
        fetchAct()
        //adding the target methods to the selected buttons by the user
        choice1.addTarget(self, action:#selector(btnSelected(selectedBtn:)), for:.touchUpInside)
        choice2.addTarget(self, action:#selector((btnSelected(selectedBtn:))), for:.touchUpInside)
        choice3.addTarget(self, action:#selector((btnSelected(selectedBtn:))), for:.touchUpInside)
        choice4.addTarget(self, action:#selector((btnSelected(selectedBtn:))), for:.touchUpInside)
        NextBtn.addTarget(self, action:#selector(btnAction), for:.touchUpInside)
        //calling a datepicker function
        dateformatter()
       
        
        if(questionNo <= 0){

            PerviousBtn.isHidden = true

                }
        // Do any additional setup after loading the view.
    }

//creating a function
func parseJson(){


    //creating a urlrequest variable for json data
    var url = Bundle.main.url(forResource:"Q&A", withExtension:"json")

    
  do {
//storing the data into variable
      let jsonData = try Data(contentsOf:url!)
//creating a instance for decoder object
      let jsonObj = JSONDecoder()
//converting the data into swift from json
    data = try jsonObj.decode([Questions].self, from:jsonData)

   // print(data)
    //accessing the data by using loops
      for i in 0..<data.count{
//adding the data into questions array
          questionsArr.append(data[i].question!)
        
        print(questionsArr)
        //adding the data into answers array
          answerDetailsArr.append(data[i].answers!)

          

      }

     

     



  } catch  {

      print("Something Went Wrong")

  }
    

}
    
    
    //creating a function for pervious Button
    @IBAction func PerviousBtnAct(_ sender: Any) {
        
        questionNo -= 1
//calling a function
                updateUI()
    }
    
    
    //creating a function for pervious Button
    @IBAction func NextBtnAct(_ sender: Any) {
        
        questionNo += 1
        //hiding pervious button
                PerviousBtn.isHidden = false
        //creating a function for pervious Button
                updateUI()

                if(questionsArr.count-1 == questionNo){

                    save.isHidden = false
                    //hiding next button
                    NextBtn.isHidden = true
                    //hiding pervious button
                    PerviousBtn.isHidden = true

                    

                }
    }
    
    
    
    //creating a function
    func updateUI(){
        //adding the text into questionsArr
            questionLbl.text = questionsArr[questionNo]

            lbl1.text = answerArr[questionNo].a

            lbl2.text = answerArr[questionNo].b

            lbl3.text = answerArr[questionNo].c
        
            lbl4.text = answerArr[questionNo].d
            

        }
    
    //creating a function
    @objc func btnAction()
    {
        if(questionsArr.count-1 == questionNo){

                   save.isHidden = false

                   NextBtn.isHidden = true

            PerviousBtn.isHidden = true

                   

               }
    }
    //creating a function
    func dateformatter(){
//adding variable of date class
            let currentDateTime = Date()
        //adding variable of dateformatter class
            let formatter = DateFormatter()
        //adding variable of formater style
            formatter.timeStyle = .medium
        //adding variable of formater date style
            formatter.dateStyle = .long
        //adding data into variable of formater
            dateTimeString = formatter.string(from:currentDateTime)

            print("The Date Time String",dateTimeString)

        }
    //creating a function
    @objc func  btnSelected(selectedBtn:UIButton){
     
        if(selectedBtn.tag == 0){
            selectedAnswer =  answerArr[questionNo].a
            
             }
        else if(selectedBtn.tag == 1){
            selectedAnswer = answerArr[questionNo].b
           
        }
        else if(selectedBtn.tag == 2){
            selectedAnswer = answerArr[questionNo].c
                    }
        else
        {
            
                selectedAnswer  = answerArr[questionNo].d!
           
        }
          print("The Selected Answer is",selectedAnswer)
        //calling a function
        createDBConnection()
        saving()


    
    }
    
   
    
    //creating a function
    func answerDetails(){

        //accesiong the data through loops
           for i in 0..<answerDetailsArr.count{
            //accesiong the data into struct file
            var answer = AnswerDetails(a:data[i].answers.map{$0.a!} as! String, b: data[i].answers.map{$0.b!} as! String, c: data[i].answers.map{$0.c!} as! String, d: data[i].answers.map{$0.d!}, correct: data[i].answers.map{$0.correct!} as! String)
//adding the values into array
               answerArr.append(answer)

               print(answerArr)

       }

       }
    //creating a function
    func createDBConnection(){
        //accessing a variable and assigning the search path domains to it
        let  path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        
        print(path)
        
      
      do
      {
        
         dbc = try Connection("\(path)/db.sqlite3")
      }
       catch
       {
        print("Error")
       }
        
        
    }
    
    
//creating a function
    
    @IBAction func fetchAct() {



        do{
            //storing the details in a table
            let stmt = try dbc.run("SELECT question,answer,Date FROM Users")
        for row in stmt {
     
        userObj = Details(question: row[0] as! String, answer: row[1] as! String, date: row[2] as! String)
            }

            //appending the details into struct
            detailsArr.append(userObj)
            print(detailsArr)
        }

        catch{
            print("ERROR")
        }
        

    }
    
    @IBAction func showSave(_ sender: Any) {
        
           //creating a instance for implementing present functionality
            var  store = storyboard?.instantiateViewController(identifier:"Details") as! DetailsViewController
        fetchAct()
            navigationController?.pushViewController(store, animated: true)
        
    }
    
    
    //creating a function
    func createTable()
    {
        do
        {
            //creating a table for accessing the details of textfield details
            try dbc.run("create table Users(question text,answer text,Date text)")
        }catch{
            print("Table not created")
        }
    }
 //creating a function
     func saving() {
        
        
        do{
            //inserting the value to  a table for accessing the details of textfield details
            try dbc.run("INSERT INTO Users (question,answer,Date) VALUES (?,?,?)",questionsArr[questionNo],selectedAnswer,dateTimeString)
            
            print("Inserted Succesfull")
            
            
        }
        
        catch{
            
            print("error Inserted Succesful")
        }
      
        
    
    }

}


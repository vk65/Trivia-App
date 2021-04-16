//
//  DetailsViewController.swift
//  Trivia App
//
//  Created by Cheripelly tirumala on 16/04/21.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    //creating a tableview
    var result:UITableView!
    
    var dateString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        //calling a function
        createUI()
        print(detailsArr)
        // Do any additional setup after loading the view.
    }
    //creating a function
    func createUI()
    {
        //assigning the properities to tableview
        result = UITableView(frame: view.frame, style: UITableView.Style.plain)
        result.delegate = self
        result.dataSource = self
        //register a nib to the tableview cell
        var cell1 = UINib(nibName: "TableViewCell", bundle: nil)
        result.register(cell1, forCellReuseIdentifier: "abc")
        DispatchQueue.main.async {
            self.result.reloadData()
        }
        view.addSubview(result)
    }
    
    //creating a function for displaying numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsArr.count
        
        
    }
    //creating a function for displaying cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "abc", for: indexPath) as! TableViewCell
        
        cell.resultLbl.text = detailsArr[indexPath.row].question
        
        cell.nameResLbl.text = detailsArr[indexPath.row].answer
        
        cell.dateLbl.text = detailsArr[indexPath.row].date
        
        return cell
    }
    
    //creating a function for increasing the height of a row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

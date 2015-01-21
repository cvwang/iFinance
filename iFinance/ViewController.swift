//
//  ViewController.swift
//  iFinance
//
//  Created by Charles Wang on 10/5/14.
//  Copyright (c) 2014 Charles Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Create a reference to a Firebase location
    var myRootRef = Firebase(url:"https://ifinance.firebaseio.com/")
    
    @IBOutlet weak var tickerTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var items = ["We", "Heart", "Swift"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        myRootRef.observeEventType(.Value, withBlock: {
//            snapshot in
//            println("\(snapshot.name) -> \(snapshot.value)")
//            self.weatherLabel.text = "\(snapshot.value)"
//        })
        
        myRootRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            var ticker = snapshot.value.objectForKey("ticker")
            var quantity = snapshot.value.objectForKey("quantity")
            println(ticker)
            println(quantity)
            self.items.append("\(ticker): \(quantity)")
            self.tableView.reloadData()
        })
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitButton(sender: AnyObject) {
        
        // This is how you group order information and then "push()" like in javascript
//        var usersRef = myRootRef.childByAppendingPath("orders")
        var order = [
            "ticker": tickerTextField.text,
            "quantity": quantityTextField.text
        ]
        var orderRef = myRootRef.childByAutoId()
        orderRef.setValue(order)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel!.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
    
}


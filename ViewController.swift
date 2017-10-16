//
//  ViewController.swift
//  GroupSorter
//
//  Created by George Andrews on 8/30/16.
//  Copyright © 2016 George Andrews. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rosterLabel: UILabel!
    @IBOutlet weak var numberOfGroupsTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sort(_ sender: AnyObject) {
        if numberOfGroupsTextField.hasText{
            let numberOfGroups = Int(numberOfGroupsTextField.text!)
            let fileName = Bundle.main.url(forResource: "roster", withExtension: "txt")!
        
        do {
            
            // Retrieve students from file
            let content = try String(contentsOf: fileName, encoding: String.Encoding.utf8)
            let students = content.components(separatedBy: "\n")
            
            // Randomize the array of students
            let randomStudents = randomizeArrayOfStrings(students)
            
            // Divide random students into 3 groups
            let groups = divideStudentsIntoGroups(randomStudents, numberOfGroups: numberOfGroups!)

            // TODO: Clean up code
            
            // FIXME: Remove commented code before shipping
            
            // Create output for rosterLabel text
//            var output = "Group 1:\n"
//            for student in groups[0] {
//                output += student + "\n"
//            }
//            
//            output += "\nGroup 2:\n"
//            for student in groups[1] {
//                output += student + "\n"
//            }
//            
//            output += "\nGroup 3:\n"
//            for student in groups[2] {
//                output += student + "\n"
//            }
            
            // Create output for rosterLabel text
            var output = createOutputForGroup(groups, atIndex: 0)
            output += createOutputForGroup(groups, atIndex: 1)
            output += createOutputForGroup(groups, atIndex: 2)
            
            rosterLabel.text = output
            
        } catch _ as NSError {
            /*do nothing */
        }
        
    }
    }
    
    // PRAGMA MARK: - Divide Students into 3 Groups and Create Ouput
    
    func randomizeArrayOfStrings(_ arrayOfStrings: [String]) -> [String] {
        if arrayOfStrings.count < 2 { return arrayOfStrings }
        var list = arrayOfStrings
        for i in 0..<(list.count - 1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            if i != j {
                swap(&list[i], &list[j])
            }
            
        }
        return list
    }
    //TODO: ask for input from user for how many groups there will be
    //func divideStudentsIntoThreeGroups(_ students: [String]) -> [[String]] {
    func divideStudentsIntoGroups(_ students: [String], numberOfGroups: Int) -> [[String]] {
    //    var groups = [[String](), [String](), [String]()]
    var groups = [[String]]()
    var i = 0
        while i < numberOfGroups {
            groups.append([String]())
            i = i + 1
        }

        var groupNumber = 0
        for student in students {
            
            groups[groupNumber].append(student)
            
            if (groupNumber < numberOfGroups) {
                groupNumber += 1
            } else {
                groupNumber = 0
            }
        }
        
        return groups
    }
    
    func createOutputForGroup(_ groups: [[String]], atIndex index: Int) -> String {
        var output = "Group \(index + 1):\n"
        for student in groups[index] {
            output += student + "\n"
        }
        return output + "\n"
    }

}


//
//  PetDetailViewController.swift
//  CoreDataAssessment
//
//  Created by Flatiron School on 10/25/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class PetDetailViewController: UIViewController {
    
    @IBOutlet weak var petNameLabel: UILabel!
    
    @IBOutlet weak var vetNameLabel: UILabel!

    @IBOutlet weak var hospitalNameLabel: UILabel!
    
    var petName: String = ""
    var vetName: String = ""
    var hospitalName: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        petNameLabel.text = petName
        vetNameLabel.text = vetName
        hospitalNameLabel.text = hospitalName
        
        print("This is printing out ")
        print(vetName)
        print(hospitalName)
        print("This is printing out ")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

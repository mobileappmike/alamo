//
//  ViewController.swift
//  alamo
//
//  Created by Michael Miles on 8/6/19.
//  Copyright © 2019 Michael Miles. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var chuckLabel: UILabel!
    @IBOutlet weak var pastebinTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getQuotePressed(_ sender: Any) {
        let url = "https://matchilling-chuck-norris-jokes-v1.p.rapidapi.com/jokes/random"
        let apiKey = "aaec687b9amsh23f3e3c98b99be3p109206jsn31495e2b36f2"
        
        let header = ["X-RapidAPI-Key" : apiKey]
        
        Alamofire.request(url, method: .get, headers: header).responseJSON { (response) in
            if response.result.isSuccess {
                print("Got it! Chuck Norris is in the building.")
                
                if let chuckResponse = response.result.value {
                    print("JSON: \(chuckResponse)")
                    let chuckJSON : JSON = JSON(chuckResponse)
                    self.chuckLabel.text = chuckJSON["value"].stringValue
                }
            } else {
                print("Alamofire error: \(String(describing: response.result.error))")
                self.chuckLabel.text = "Alamofire Issues"
            }
        }
    }
    
    @IBAction func pastebinButtonPressed(_ sender: Any) {
        let url = "https://pastebin.com/api/api_post.php"
        let apiKey = "5e8fc5f765ba88c3693d356d9c24cc16"
        
        let params = [
            "api_dev_key" : apiKey,
            "api_option" : "paste",
            "api_paste_code" : pastebinTextField.text ?? "No text entered"
        ]
        
        Alamofire.request(url, method: .post, parameters: params).responseString { (response) in
            if response.result.isSuccess {
                print("Find your pasted result @ \(response)")
            } else {
                print("pastebin post issues")
            }
        }
    }
    

}


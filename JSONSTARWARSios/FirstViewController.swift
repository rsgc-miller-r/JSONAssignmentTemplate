//
//  FirstViewController.swift
//  JSONSTARWARSios
//
//  Created by Gorrila 8Ball Ribs on 2016-05-23.
//  Copyright © 2016 Gorrila 8Ball Ribs. All rights reserved.
//



// THIS IS THE PLANET CONTROLLER

import UIKit
import Foundation

var baal : Bool = false

var isKill : String = ""

var planetaddress = String("http://swapi.co/api/planets/?format=json")

class FirstViewController: UIViewController {
    
    
    func parseMyJSON(theData : NSData) {
        
        //print(theData)
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(theData, options: NSJSONReadingOptions.AllowFragments)
            
            //print(json)
            
            if let value = json as? [String : AnyObject] {
                
                if let results = value["results"] as? [AnyObject]{
                    //print(results)
                    isKill = ""
                    print("IS 1")
                    print(isKill)
                    for data in results {
                        
                        let range = String(data["name"]).startIndex.advancedBy(9)..<String(data["name"]).endIndex.advancedBy(-1)
                        
                        let rangeGrav = String(data["gravity"]).startIndex.advancedBy(9)..<String(data["gravity"]).endIndex.advancedBy(-1)
                        
                        let rangeOrbit = String(data["orbital_period"]).startIndex.advancedBy(9)..<String(data["orbital_period"]).endIndex.advancedBy(-1)
                        
                        let rangePop = String(data["population"]).startIndex.advancedBy(9)..<String(data["population"]).endIndex.advancedBy(-1)
                        
                        let rangeRot = String(data["rotation_period"]).startIndex.advancedBy(9)..<String(data["rotation_period"]).endIndex.advancedBy(-1)
                        
                        let rangeSW = String(data["surface_water"]).startIndex.advancedBy(9)..<String(data["surface_water"]).endIndex.advancedBy(-1)
                        
                        let rangeTerrain = String(data["terrain"]).startIndex.advancedBy(9)..<String(data["terrain"]).endIndex.advancedBy(-1)
                        
                        
                        if (baal == true) {
                            if (self.PlanetSearchText.text == String(data["name"])[range]) {
                                
                                print(data)
                                isKill += "Gravity :" + String(data["gravity"])[rangeGrav] + "\n"
                                isKill += "Orbital Period :" + String(data["orbital_period"])[rangeOrbit] + "\n"
                                isKill += "Population :" + String(data["population"])[rangePop] + "\n"
                                isKill += "Rotation Period :" + String(data["rotation_period"])[rangeRot] + "\n"
                                isKill += "Surface Water (Square Miles) :" + String(data["surface_water"])[rangeSW] + "\n"
                                isKill += "Terrain :" + String(data["terrain"])[rangeTerrain] + "\n"
                                
                            }
                            
                        } else {
                        
                                                String(data["name"])
                        print(String(data["name"])[range])
                        isKill += (String(self.planetText.text) + String(data["name"])[range] + "\n")
                        print("IS 2")
                        print(isKill)
                        }

                    }
                }
            }
            
            
            dispatch_async(dispatch_get_main_queue()) {
                if isKill != "" {
                    self.planetText.text = ""
                    self.planetText.text = isKill
                }
                baal = false
            }
            
            
        } catch let error as NSError {
            print ("Failed to load: \(error.localizedDescription)")
        }
        
        
    }
    
    
    func getMyJSON() {
        let myCompletionHandler : (NSData?, NSURLResponse?, NSError?) -> Void = {
            
            (data, response, error) in
            /*print("")
            print("</here da data/>")
            print(data)
            print("")
            print("</here da respons/>")
            print(response)
            print("")
            print("</here da godforsaken errors/>")
            print(error)*/
            
            if let r = response as? NSHTTPURLResponse {
                
                if r.statusCode == 200 {
                    
                    if let d = data {
                        self.parseMyJSON(d)
                        
                        
                        
                    }
                    
                }
                
            }
            
        }
        
        
        
        let address : String = planetaddress
        
        if let url = NSURL(string: address) {
            
          //  print(url)
            
            let urlRequest = NSURLRequest(URL: url)
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            let task = session.dataTaskWithRequest(urlRequest, completionHandler: myCompletionHandler)
            
            task.resume()
            
        } else {
            print("Error: Cannot create the NSURL object.")
            
            
            
        }
        
    }
    
    var representedObject: AnyObject? {
        didSet {
        }
    }

    @IBOutlet weak var planetText: UITextView!

    @IBAction func planetButton(sender: UIButton) {
        isKill = ""
        self.getMyJSON()
        
    }

    @IBAction func PlanetSearchButton(sender: UIButton) {
        isKill = ""
        baal = true
        
        getMyJSON()
    }
    
    @IBOutlet weak var PlanetSearchText: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    override func didReceiveMemoryWarning() {
  
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

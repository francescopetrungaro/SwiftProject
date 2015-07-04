//
//  Utilities.swift
//  SwiftProject
//
//  Created by Francesco on 04/07/2015.
//  Copyright (c) 2015 Francesco Petrungaro. All rights reserved.
//

import Foundation
import UIKit

public class Utilities {
    
    public class func formattedTemperature(temperature : NSNumber?) -> NSAttributedString {
        let labelText : String?
        
        if let temperature = temperature {
            labelText = "<p>London : <b>\(temperature) K</b></p>"
        }
        else{
            labelText = "<b>Uknown Temperature</b>"
        }
        
        let font:UIFont? = UIFont(name: "Arial", size: 12.0)
        
        return NSAttributedString(fromHTML: labelText)
    }
    
    public class func formattedDescription(description : String?) -> String {
        
        var weatherDescription : String?
        
        if let description = description {
            var descriptionLowercase = NSString(string: description.lowercaseString)
            if (descriptionLowercase.containsString("sun")){
                weatherDescription = "Enjoy the Sun"
            }
            else{
                weatherDescription = description.capitalizedString
            }
        }else{
            weatherDescription = "Weather"
        }
        
        return weatherDescription!;
    }
}
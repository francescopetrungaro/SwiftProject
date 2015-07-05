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
        
        return NSAttributedString(fromHTML: labelText)
    }
    
    public class func formattedDescription(description : String?) -> String {
        
        var weatherDescription : String?
        
        if let description = description {
            var descriptionLowercase = NSString(string: description.lowercaseString)
            if (descriptionLowercase.containsString("sky is clear")){
                weatherDescription = "Enjoy the Sun\n\n\(NSDate().formattedDate()) "
            }
            else{
                weatherDescription = "\(description.capitalizedString)\n\n\(NSDate().formattedDate())"
            }
        }else{
            weatherDescription = "Weather"
        }
        
        return weatherDescription!;
    }
}
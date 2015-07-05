/*
Copyright (c) 2015 Francesco Petrungaro. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY Francesco Petrungaro `AS IS' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
EVENT SHALL Francesco Petrungaro OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import UIKit
import APUtils
import XCGLogger

public let logger = XCGLogger.defaultInstance()

public typealias NetworkManagerCompletionBlock = (NSNumber?, String?) -> Void

public class NetworkManager: NSObject {
    
    public class var sharedInstance: NetworkManager {
        struct Static {
            static var instance: NetworkManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = NetworkManager()
        }
        
        return Static.instance!
    }
    
    override init() {
        super.init()
        logger.debug("NetworkManager init");
    }
    
     public func fetchTemperature(completionBlock : NetworkManagerCompletionBlock? = nil){
        
        var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var session = NSURLSession(configuration: configuration, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        
        var string = String(format: "http://api.openweathermap.org/data/2.5/weather?q=London,uk")
        
        var url = NSURL(string: string)
        
        var task = session.dataTaskWithURL(url!){
            (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            
            var error: NSError?
            var temperature : NSNumber?
            var temperatureDescription : String?
            
            var resultDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as? NSDictionary

            if (error != nil) {
                logger.severe("JSON Error \(error!.localizedDescription)");
            }
            else{
                if let resultDictionary = resultDictionary {
                    logger.debug("\(resultDictionary)")
                    
                    temperature = NetworkManager.temperatureFromDictionary(resultDictionary)
                    temperatureDescription = NetworkManager.temperatureDescriptionFromDictionary(resultDictionary)
                }
            }
            
            if let completion = completionBlock{
                completion(temperature, temperatureDescription)
            }
        }
        task.resume()
    }
    
    class func temperatureFromDictionary(resultDictionary: NSDictionary) -> NSNumber? {
        let mainDictionary = resultDictionary["main"] as? NSDictionary
        
        if let mainDictionary = mainDictionary {
            return mainDictionary["temp"] as? Double
        }
        return nil
    }
    
    class func temperatureDescriptionFromDictionary(resultDictionary: NSDictionary) -> String? {
        let weatherArray = resultDictionary["weather"] as? NSArray
        
        if let weatherArray = weatherArray {
            if weatherArray.count > 0 {
                let weatherDictionary = weatherArray.firstObject as? NSDictionary
                if let weatherDictionary = weatherDictionary {
                    return weatherDictionary["description"] as? String
                }
            }
        }
        return nil
    }
}

//
//  APIManager.swift
//  RestAPIManager
//
//  Created by Appinventiv on 19/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//
import UIKit

class APIManager {
    
    let headers = [
        "Cache-Control": "no-cache",
        "Postman-Token": "31c411b7-c48e-4411-a656-e595f11aa7c2"
    ]
    
    //MARK:--> GET Request
    func loginGet(parameters: [String:Any], success: @escaping (Entities) -> Void){
        
        let newString = self.stringMutation(parameters)
        let baseURL = "https://httpbin.org/get?Username=\(newString)&Password=\(parameters["Password"]!)"
        
        //MARK:--> Calling Network Manager
        NetworkManager().GET(headers: headers, url: baseURL, success:{ (data) in
            success(Entities(args: data))}){error in print(Error.self)}
    }
    
    //MARK:--> POST Request
    func loginPost(forms: [String:Any], success: @escaping (Entities) -> Void,  failure: (Error)-> Void){
        let headers = [
            "content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
            "Cache-Control": "no-cache",
            "Postman-Token": "177f5629-33da-45a5-992e-2a8565919c11"
        ]
        let newString = self.stringMutation(forms)
        let baseURL = "https://httpbin.org/post?Username=\(newString)&Password=\(forms["Password"]!)"
        
        let body = "Username=\(newString)&Password=\(forms["Password"]!)"
        
        NetworkManager().POST(headers: headers, body: body, url: baseURL, success: {(data) in success(Entities(args: data))}){(error) in print(Error.self)
        }
    }
}

extension APIManager{
    
    //MARK:--> Creating a url string
    func stringMutation(_ dict: [String:Any])-> String{
        let str = dict["Username"] as? String
        let newStr = str?.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        return newStr!
    }
}

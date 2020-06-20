//
//  Api.swift
//  desafioIos
//
//  Created by Mateus Fernandes on 19/06/20.
//  Copyright © 2020 Mateus Fernandes. All rights reserved.
//

import Foundation

class Api {
    
    private static let baseUrlPath = "https://api.imgur.com/3/gallery/search/?q=cats"
    
    private static let configSession = { () -> URLSessionConfiguration in
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type":"application/json", "Authoriation": "Client-ID 2a6ffbfa4cd6c42", "Authorization": "Bearer 63304579bb49ec6859a015db629ba180ee1792d8"]
        return config
    }()
    
    
    //MARK: - Session Object
    private static let session = URLSession(configuration: configSession);
    
    //MARK: - Method to get Data form API
    class func getCats(onCompleted: @escaping ([Cat]) -> Void){
        guard let url =  URL(string: baseUrlPath) else { return }
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        var catsList:[Cat] = []
                        if let cats = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                            if let catsData = cats["data"] as? Array<Dictionary<String, Any>>{
                                for cat in catsData{
                                    if let catsImages = cat["images"] as? Array<Dictionary<String, Any>>{
                                        for catImage in catsImages {
                                            if let links = catImage["link"] as? String {
                                                catsList.append(Cat(linkImg: links))
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        onCompleted(catsList)
                    }catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                }
            }else{
                print(error!)
            }
        }
        dataTask.resume()
    }
}

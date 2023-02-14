//
//  RemoteImageHelper.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 6/2/23.
//

import Foundation
import UIKit
func getRemoteImage(from urlString: String, completion: @escaping (UIImage?) -> Void){
    let url = URL(string: urlString)!
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else { return }
        completion(UIImage(data: data))
    }.resume()
}

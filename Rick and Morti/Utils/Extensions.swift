//
//  Extensions.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 6/2/23.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alert, animated: true)
    }
}

extension UIImageView {
    func remoteImage(from urlString: String, contentMode mode: ContentMode = .scaleAspectFit){
        contentMode = mode
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                        let data = data, error == nil,
                        let image = UIImage(data: data)
                        else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
}

extension UITableViewController{
    func createFotterSpinnerView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        
        let spinnerView = UIActivityIndicatorView()
        spinnerView.center = footerView.center
        footerView.addSubview(spinnerView)
        spinnerView.startAnimating()
        
        return footerView
    }
}

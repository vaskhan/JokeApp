import Foundation
import UIKit

class AlertPresenter {
    private weak var viewСontroller: UIViewController?
    
    init(viewСontroller: UIViewController? = nil) {
        self.viewСontroller = viewСontroller
    }
    
    func showAlert(model: AlertModel){
        let alert = UIAlertController(
            title: model.title, 
            message: model.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion?()
        }
        alert.addAction(action)
        viewСontroller?.present(alert, animated: true, completion: nil)
    }
}

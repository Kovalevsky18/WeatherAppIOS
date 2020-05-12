import UIKit
class GetInfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.startLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(controller, animated: true )
    }
    
    func alert() {
        let alert = UIAlertController(title: "Error", message: "Check your internet connection and reopen app", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        self.present(alert, animated:true, completion: nil)
    }
    
}

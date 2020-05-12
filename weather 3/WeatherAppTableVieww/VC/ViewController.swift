import UIKit
import Foundation
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveImageView: UIImageView!
    @IBOutlet weak var uploadImageView: UIImageView!
    var defaults = ConnectionManager.shared.defaults
    let viewsArray = [MainWeatherInfo.instanceFromNib(),WeatherCollectionView.instanceFromNib(),WeatherTableViewInfo.instanceFromNib(),MoreWeatherInfo.instanceFromNib()]
    let sizeArray = [MainWeatherInfo.instanceFromNib().frame.size.height,WeatherCollectionView.instanceFromNib().frame.size.height,WeatherTableViewInfo.instanceFromNib().frame.size.height,MoreWeatherInfo.instanceFromNib().frame.size.height]
    
    override func viewDidLoad() {
        detect()
    }
    
    func detect() {
        let saveDetector = UITapGestureRecognizer(target: self, action:#selector(saveAction(_:)))
        saveDetector.numberOfTapsRequired = 1
        self.saveImageView.addGestureRecognizer(saveDetector)
        
        let uploadDetector = UITapGestureRecognizer(target: self, action:#selector(uploadAction(_:)))
        uploadDetector.numberOfTapsRequired = 1
        self.uploadImageView.addGestureRecognizer(uploadDetector)
    }
    
    @IBAction func saveAction(_ sender:UITapGestureRecognizer){
        if let location = LocationManager.shared.location{
            ConnectionManager.shared.getJsonByLocation(lat: location.latitude, long: location.longitude) { (result, error) in
                guard let city = result?.name,let temp = result?.main?.temp,let description = result?.weather?[0].description else {return}
                
                self.defaults.set(city, forKey: "city")
                self.defaults.set(Int(temp), forKey: "mainTemp")
                self.defaults.set(description, forKey: "description")
                self.defaults.set(true, forKey: "save")
            }
        }        
    }
    
    @IBAction func uploadAction(_ sender:UITapGestureRecognizer){
        let controller = storyboard?.instantiateViewController(withIdentifier: "GetInfoViewController") as! GetInfoViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as? TableViewCell  else {return UITableViewCell()}
        self.tableView.rowHeight = sizeArray[indexPath.row]+5
        cell.contentView.addSubview(viewsArray[indexPath.row])
        return cell
    }
    
    
}


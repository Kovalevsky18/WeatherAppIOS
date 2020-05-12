import Foundation
import UIKit
import CoreLocation
class MainWeatherInfo:UIView{
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        if ConnectionManager.shared.defaults.bool(forKey: "save") == true {
            cityLabel.text = ConnectionManager.shared.defaults.string(forKey: "city")
            descriptionLabel.text = ConnectionManager.shared.defaults.string(forKey: "description")
            tempLabel.text = String(ConnectionManager.shared.defaults.integer(forKey: "mainTemp")) + "°"
        }
        else {
            if let location = LocationManager.shared.location{
                ConnectionManager.shared.getJsonByLocation(lat: location.latitude, long: location.longitude) { (data, error) in
                    DispatchQueue.main.async {
                        guard let city = data?.name,let temp = data?.main?.temp,let description = data?.weather?[0].description else {return}
                        self.cityLabel.text = city
                        self.tempLabel.text = " " + String(Int(temp)) + "°"
                        self.descriptionLabel.text = description
                    }
                }
            }
        }
    }
    
    static func instanceFromNib()->MainWeatherInfo{
        return UINib(nibName: "MainWeatherInfo", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView as! MainWeatherInfo
    }
}

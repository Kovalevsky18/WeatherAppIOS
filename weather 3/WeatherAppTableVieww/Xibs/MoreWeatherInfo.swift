
import Foundation
import UIKit
import CoreLocation
class MoreWeatherInfo:UIView{
    
    @IBOutlet weak var tempMaxNameLabel: UILabel!
    @IBOutlet weak var tempMinNameLabel: UILabel!
    @IBOutlet weak var feelsLikeNameLabel: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    
    override func awakeFromNib() {
        if ConnectionManager.shared.defaults.bool(forKey: "save") == true {
            feelsLike.isHidden = true
            tempMin.isHidden = true
            tempMax.isHidden = true
            feelsLikeNameLabel.isHidden = true
            tempMinNameLabel.isHidden = true
            tempMaxNameLabel.isHidden = true
            ConnectionManager.shared.defaults.set(false,forKey:"save")
        }
        else {
            if let location = LocationManager.shared.location {
                ConnectionManager.shared.getJsonByLocation(lat: location.latitude, long: location.longitude) { (data, error) in
                    DispatchQueue.main.async {
                        guard let feelsLike = data?.main?.feels_like,let tempMax = data?.main?.temp_max,let tempMin = data?.main?.temp_min
                            else {return}
                        self.feelsLike.text = String(Int(feelsLike)) + "°"
                        self.tempMax.text = String(Int(tempMax)) + "°"
                        self.tempMin.text = String(Int(tempMin)) + "°"
                    }
                }
            }
        }
    }
    
    static func instanceFromNib()->MoreWeatherInfo{
        return UINib(nibName: "MoreWeatherInfo", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView as! MoreWeatherInfo
    }
}


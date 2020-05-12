import Foundation
import UIKit
import CoreLocation
class WeatherTableViewInfo: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        self.tableView.register(UINib.init(nibName: "cellWeatherTableView", bundle: nil), forCellReuseIdentifier: "cell")
        if ConnectionManager.shared.defaults.bool(forKey: "save") == true{
            tableView.isHidden = true
        }
    }
    
    static func instanceFromNib()->WeatherTableViewInfo{
        return UINib(nibName: "WeatherTableViewInfo", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView as! WeatherTableViewInfo
    }
}

extension WeatherTableViewInfo:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as? cellWeatherTableView  else {return UITableViewCell()}
        if let location = LocationManager.shared.location{
            
            ConnectionManager.shared.getJSONDailyWeather(lat: location.latitude, lon: location.longitude) { (result, error) in
                DispatchQueue.main.async {
                    guard let date = result?.daily![indexPath.row].dt?.description, let temp = result?.daily![indexPath.row].temp?.max,let icon = result?.daily![indexPath.row].weather?[0].icon
                        else{return}
                    
                    var weekday: String {
                        guard let newData = TimeInterval(date) else {return String()}
                        let date = Date(timeIntervalSince1970: newData)
                        let formatter = DateFormatter()
                        formatter.dateFormat = "EEEE"
                        return formatter.string(from: date)
                        
                    }
                    cell.dayLabel.text = weekday
                    cell.degreeLabel.text = String(Int(temp)) + "°"
                    cell.imageViewOutlet.image = UIImage(named: icon)                    }
            }
            
            
        }
        return cell
    }
}



import Foundation
import UIKit
class WeatherCollectionView:UIView  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        self.collectionView.register(UINib.init(nibName: "cellWeatherCollectionView", bundle: nil), forCellWithReuseIdentifier: "cellCollectionView")
        
        if ConnectionManager.shared.defaults.bool(forKey: "save") == true {
            collectionView.isHidden = true
        }
    }
    
    static func instanceFromNib()->WeatherCollectionView{
        return UINib(nibName: "WeatherCollectionView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView as! WeatherCollectionView
    }
}

extension WeatherCollectionView:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCollectionView", for: indexPath as IndexPath) as? cellWeatherCollectionView  else {return UICollectionViewCell()}
        if let location = LocationManager.shared.location{
            ConnectionManager.shared.getJSONSearchHourlyWeather(lat:location.latitude , lon:location.longitude ) { [weak self] result, error in
                if let error = error {
                    print(error)
                } else {
                    guard let image = result?.list?.first?.weather?.first?.icon, let data = result?.list![indexPath.row].dt?.description, let temp = result?.list![indexPath.row].main?.temp else {
                        return
                    }
                    DispatchQueue.main.async {
                        var weekday: String {
                            guard let newData = TimeInterval(data) else {return String()}
                            let date = Date(timeIntervalSince1970: newData)
                            let formatter = DateFormatter()
                            formatter.dateFormat = "HH:ss"
                            return formatter.string(from: date)
                        }
                        cell.time.text = weekday
                        cell.weatherDegree.text = String(Int(temp)) + "°"
                        cell.weatherImage.image = UIImage(named: image)
                    }
                }
            }
        }
        return cell
    }
}


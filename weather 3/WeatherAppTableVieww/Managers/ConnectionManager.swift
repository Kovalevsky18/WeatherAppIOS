import Foundation
class ConnectionManager {
    static let shared  = ConnectionManager()
    init() {}
    var weatherLoc = WeatherLoc()
    let defaults = UserDefaults.standard

    func getJsonByLocation(lat:Double,long:Double,handler: @escaping(_ weather: WeatherLoc?, _ error: Error?)->()) {
        let session = URLSession.shared
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&units=metric&lang=en&APPID=a632e471f0b9c0c8bb09710584a6c1cc&units=metric") else {
            return
        }
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("\(error!.localizedDescription)")
                return
            }
            do {
                self.weatherLoc = try JSONDecoder().decode(WeatherLoc.self, from: data!)
                handler(self.weatherLoc, nil)
            } catch let error{
                handler(nil, error)
            }
        }
        task.resume()
    }
    
    func getJSONSearchHourlyWeather(lat: Double,lon:Double, complition: @escaping (_ result : OfferModel?, _ error: Error?)->()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&units=metric&lang=ru&APPID=a632e471f0b9c0c8bb09710584a6c1cc&lon=\(lon)") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil, let data = data {
                if let response = try? JSONDecoder().decode(OfferModel.self, from: data) {
                    complition(response, nil)
                }
            } else {
                let error = NSError(domain: "ERROR", code: 0, userInfo: [:])
                print(error)
                complition(nil, error)
            }
        }
        task.resume()
    }
    
    func getJSONDailyWeather(lat: Double,lon:Double, complition: @escaping (_ result : DailyWeather?, _ error: Error?)->()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=hourly&appid=a632e471f0b9c0c8bb09710584a6c1cc&units=metric") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil, let data = data {
                if let response = try? JSONDecoder().decode(DailyWeather.self, from: data) {
                    complition(response, nil)
                }
            } else {
                let error = NSError(domain: "ERROR", code: 0, userInfo: [:])
                print(error)
                complition(nil, error)
            }
        }
        task.resume()
    }

}

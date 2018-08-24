//
//  HomeTabVC.swift
//  KEPCOde
//
//  Created by 박세은 on 2018. 8. 24..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import Firebase

class HomeTabVC: UIViewController,CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var whetherCollectionView: UICollectionView!
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var kwLabel: UILabel!
    
    @IBOutlet weak var reserveButton: UIButton!
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation? {
        didSet {
            networkBoard()
        }
    }
    
    var collGrid : Grid?
    var collSky : Sky2?
    var collTemp : Temperature2?
    
    let ud = UserDefaults.standard
    
    var amount = "" {
        didSet{
            kwCheck()
        }
    }
    
    var tempArr: [String] = []
    var nameArr: [String] = []
    
    @IBAction func reserveAction(_ sender: UIButton) {
        self.present(UIStoryboard(name: "MainTab", bundle: nil).instantiateViewController(withIdentifier: "ReservationVC"), animated: true) {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        kwLabel.isHidden = true
        whetherCollectionView.delegate = self
        whetherCollectionView.dataSource = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() //권한 요청
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        dataInit()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataInit()
    }
    
    func kwCheck() {
        if amount == "" {
            kwLabel.isHidden = true
            emptyLabel.isHidden = false
            
        } else {
            kwLabel.isHidden = false
            emptyLabel.isHidden = true
            kwLabel.text = amount + "Kw"
            
            reserveButton.titleLabel?.text = "수정하기"
        }
    }
    
    func dataInit() {
        let getid = ud.value(forKey: "uid") as! String
        
        Database.database().reference().child("users").child(getid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.amount = value?["volume"] as? String ?? ""
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied{
            showLocationDisableAlert()
        } else {
            currentLocation = manager.location
        }
    }
    
    func showLocationDisableAlert() {
        let alertController = UIAlertController(title: "위치 접근이 제한되었습니다.", message: "주변 날씨 정보를 보기 위해 위치 정보가 필요합니다.", preferredStyle: .alert)
        let openAction = UIAlertAction(title: "설정으로 가기", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func networkBoard(){
        let URL = "https://api2.sktelecom.com/weather/current/minutely"
        let URL2 = "https://api2.sktelecom.com/weather/forecast/3days"
        let header = [
            "appKey" : "1b33e822-df2a-4fd3-9246-cf3d58844811"
        ]
        let params = [
            "version" : 1,
            "lat" : currentLocation?.coordinate.latitude,
            "lon" : currentLocation?.coordinate.longitude
        ]
        
        Alamofire.request(URL2, method: .get, parameters: params, headers: header).responseData(){ res in
            switch res.result{
            case .success:
                if let value = res.result.value{
                    print("------------------success---------------------")
                    //                    JSON(value) // json값으로 푸는거(swiftyJSON)
                    print(JSON(value)["result"])
                    print(JSON(value)["result"]["message"].string!)
                    let decoder = JSONDecoder()
                    do {
                        let mother2 = try decoder.decode(Mother2.self, from: value)
                        let weather = mother2.weather
                        print("---------------1------------------")
                        if(JSON(value)["result"]["message"].string == "성공"){
                            print("---------------2------------------")
                            let fore = weather.forecast3days[0]
                            
                            self.collGrid = fore.grid
                            self.locationLabel.text = ((self.collGrid?.county)! + " " + (self.collGrid?.village)!)
                            self.collSky = fore.fcst3hour.sky
                            self.collTemp = fore.fcst3hour.temperature
                            self.tempArr.removeAll()
                            self.tempArr.append((self.collTemp?.temp4hour)!)
                            self.tempArr.append((self.collTemp?.temp7hour)!)
                            self.tempArr.append((self.collTemp?.temp10hour)!)
                            self.tempArr.append((self.collTemp?.temp13hour)!)
                            self.tempArr.append((self.collTemp?.temp16hour)!)
                            self.tempArr.append((self.collTemp?.temp19hour)!)
                            self.tempArr.append((self.collTemp?.temp22hour)!)
                            self.tempArr.append((self.collTemp?.temp25hour)!)
                            self.tempArr.append((self.collTemp?.temp28hour)!)
                            self.tempArr.append((self.collTemp?.temp31hour)!)
                            self.tempArr.append((self.collTemp?.temp34hour)!)
                            
                            self.nameArr.removeAll()
                            self.nameArr.append((self.collSky?.name4hour)!)
                            self.nameArr.append((self.collSky?.name7hour)!)
                            self.nameArr.append((self.collSky?.name10hour)!)
                            self.nameArr.append((self.collSky?.name13hour)!)
                            self.nameArr.append((self.collSky?.name16hour)!)
                            self.nameArr.append((self.collSky?.name19hour)!)
                            self.nameArr.append((self.collSky?.name22hour)!)
                            self.nameArr.append((self.collSky?.name25hour)!)
                            self.nameArr.append((self.collSky?.name28hour)!)
                            self.nameArr.append((self.collSky?.name31hour)!)
                            self.nameArr.append((self.collSky?.name34hour)!)
                            
                            
                            self.whetherCollectionView.reloadData()
                        }
                    }catch{
                        print("catch")
                    }
                }
                break
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
            
        }
        
        Alamofire.request(URL, method: .get, parameters: params, headers: header).responseData(){ res in
            switch res.result{
            case .success:
                if let value = res.result.value{
                    print("------------------success---------------------")
                    //                    JSON(value) // json값으로 푸는거(swiftyJSON)
                    print(JSON(value)["result"]["message"].string!)
                    let decoder = JSONDecoder()
                    do {
                        let mother = try decoder.decode(Mother.self, from: value)
                        let weather = mother.weather
                        print("---------------1------------------")
                        if(JSON(value)["result"]["message"].string == "성공"){
                            print("---------------2------------------")
                            let minu = weather.minutely[0]
//                            if minu.sky.name == "맑음"{
//                                self.skyImage.image = #imageLiteral(resourceName: "01")
//                            }else if minu.sky.name == "구름많음"{
//                                self.skyImage.image = #imageLiteral(resourceName: "03")
//                            }else if minu.sky.name == "구름조금"{
//                                self.skyImage.image = #imageLiteral(resourceName: "02")
//                            }
//                            self.skyLabel.text = minu.sky.name
//                            self.tcLabel.text = minu.temperature.tc
//                            self.tmaxLabel.text = minu.temperature.tmax
//                            self.tminLabel.text = minu.temperature.tmin
                        }
                    }catch{
                        print("catch")
                    }
                }
                break
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
//        cell.cellVillageLabel.text = self.collGrid?.village
//        cell.cellCountyLabel.text = self.collGrid?.county
        // get the current date and time
        let currentDateTime = Date()
        
        // get the user's calendar
        let userCalendar = Calendar.current
        
        // choose which date and time components are needed
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        
        // get the components
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        
        // now the components are available
        let hour = dateTimeComponents.hour   // 22
        
        if indexPath.item == 0 {
            cell.cellTimeLabel.text = "지금"
            
        } else {
            if Int(hour!) + indexPath.item * 3 < 24 {
                
                if Int(hour!) + indexPath.item * 3 < 10 {
                    cell.cellTimeLabel.text = "0" + "\(Int(hour!) + indexPath.item * 3)시"
                } else {
                
                cell.cellTimeLabel.text = "\(Int(hour!) + indexPath.item * 3)시"
                }
            } else {
                if Int(hour!) + indexPath.item * 3 - 24 < 10 {
                    cell.cellTimeLabel.text = "0" + "\(Int(hour!) + indexPath.item * 3 - 24)시"
                } else {
                    cell.cellTimeLabel.text = "\(Int(hour!) + indexPath.item * 3 - 24)시"
                }
            }
        }
        
        cell.cellTemperatureLabel.text = String(self.tempArr[indexPath.item].split(separator: ".", maxSplits: 1, omittingEmptySubsequences: true)[0])
        
        cell.cellTemperatureLabel.text = cell.cellTemperatureLabel.text! + "℃"
        let name = self.nameArr[indexPath.item]
        if name == "맑음"{
            cell.cellImage.image = #imageLiteral(resourceName: "01")
        }else if name == "구름많음"{
            cell.cellImage.image = #imageLiteral(resourceName: "03")
        }else if name == "구름조금"{
            cell.cellImage.image = #imageLiteral(resourceName: "02")
        }else if name == "흐림"{
            cell.cellImage.image = #imageLiteral(resourceName: "07")
        }
        
        return cell
        
    }
    
}


//
//  ViewController.swift
//  Map
//
//  Created by inooph on 2021/10/23.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var lblLocationInfo1: UILabel!
    @IBOutlet weak var lblLocationInfo2: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도 최고로 설정
        locationManager.requestWhenInUseAuthorization() // 위치데이터 추적위한 사용자 승인요구
        locationManager.startUpdatingLocation() // 위치 업데이트 시작
        myMap.showsUserLocation = true // 위치 보기 설정
    }
    
    // MARK: - 위도, 경도 스팬(영역폭) 입력받아 지도에 표시
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double)-> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    // MARK: - 특정위도, 경도 핀 설치 - 핀에 타이틀, 서브타이틀 문자열 표시
    func setAnnotation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle:String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    
    // MARK: - 위치 정보에서 국가, 지역, 도로 추출하여 레이블에 표시
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last // 마지막 위치값
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01) // 0.01 -> 100배 확대
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            
            let pm = placemarks!.first
            let country = pm!.country
            var address: String = country!
            
            if pm!.locality != nil { // 지역값
                address += ""
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil { // 도로값
                address += ""
                address += pm!.thoroughfare!
            }
            self.lblLocationInfo1.text = "현재위치"
            self.lblLocationInfo2.text = address
        })
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - 세그먼트 컨트롤을 선택하였을 때 호출
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 { // 현재위치 표시
            self.lblLocationInfo1.text = ""
            self.lblLocationInfo2.text = ""
            locationManager.startUpdatingLocation()
        } else if sender.selectedSegmentIndex == 1 { // 폴리텍 대학 표시
            setAnnotation(latitude: 37.351853, longitude: 128.87605740000004, delta: 1, title: "강릉폴리텍", subtitle: "강원도 강릉시 남산초교길 121")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "강릉폴리텍"
        } else if sender.selectedSegmentIndex == 2 { // 이지스퍼블리싱 표시
            setAnnotation(latitude: 37.5307871, longitude: 126.8981, delta: 0.1, title: "이지스 퍼블리싱", subtitle: "서울시 영등포구 당산로 41길 11")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "이지스 퍼블리싱 출판사"
        } else if sender.selectedSegmentIndex == 3 {
            setAnnotation(latitude: 37.28136040277657, longitude: 127.03059866031059, delta: 0.1, title: "우리집(식당)", subtitle: "경기 수원시 영통구 월드컵로179번길 48")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "우리집(식당)"
        }
    }
}


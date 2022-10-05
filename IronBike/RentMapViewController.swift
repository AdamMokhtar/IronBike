

import UIKit
import MapKit
import CoreLocation

class RentMapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var venues = [Venue]()
    let regoinInMeters:Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let initioalLocation = CLLocation(latitude: 51.445910, longitude: 5.492095)
//        zoomMapOn(location: initioalLocation)
        
        let venues = [GGcompany,James_Company,Alex_bike,Starbucks_bike]
        mapView.addAnnotations(venues)
        
        mapView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkLocationServiceAuthenticationStatus()
    }
    
    private let regionRadius: CLLocationDistance = 1000
    func zoomMapOn(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: regionRadius * 2.0,longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta:regoinInMeters , longitudeDelta: regoinInMeters))
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    let GGcompany = Venue(title: "Btwin, Renter:Alex", price: "Fix price € 15,00", coordinate: CLLocationCoordinate2D(latitude: 51.448289, longitude: 5.490989), image: UIImage(named: "Btwin")!)
    
    let James_Company = Venue(title: "Gazelle, Renter:James", price: "Fix price € 15,00", coordinate: CLLocationCoordinate2D(latitude: 51.447073, longitude: 5.495439),image: UIImage(named: "gazelle")!)
    
    let Alex_bike = Venue(title: "Stromer, Renter:Henry", price: "Fix price € 15,00", coordinate: CLLocationCoordinate2D(latitude: 51.452876, longitude: 5.496176),image: UIImage(named: "Stromer")!)
    
    let Starbucks_bike = Venue(title: "Stromer, Renter:Marie ", price: "Fix price € 15,00", coordinate: CLLocationCoordinate2D(latitude: 51.449508, longitude: 5.479961),image: UIImage(named: "Stromer-ST1-White")!)
    
     var locationManager = CLLocationManager()
  
    func checkLocationServiceAuthenticationStatus()
    {
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }

}
extension RentMapViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
       // let location = locations.last!
        self.mapView.showsUserLocation = true
       // zoomMapOn(location: location)
    }
}

extension RentMapViewController : MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if let annotation = annotation as? Venue {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -20, y: 20)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
                
                //forImage
                let imageview = UIImageView.init(frame:CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 50)))
                imageview.image = annotation.image
                view.leftCalloutAccessoryView = imageview
                
            }
            
            return view
        }
        
        return nil
}
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        let location = view.annotation as! Venue
        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
        
    }
}

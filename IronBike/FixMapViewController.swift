

import UIKit
import MapKit
import CoreLocation


//,CLLocationManagerDelegate
class FixMapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var venues = [Venue]()
//    let locationManager = CLLocationManager()
    let regoinInMeters:Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
     //   checkLocationSercices()
        //createAnnotations(locations: annotationLocations)
        let initioalLocation = CLLocation(latitude: 51.445910, longitude: 5.492095)
        zoomMapOn(location: initioalLocation)
        
        let venues = [GGcompany,James_Company,Alex_bike,Starbucks_bike]
        mapView.addAnnotations(venues)
        
         mapView.delegate = self
        }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkLocationServiceAuthenticationStatus()
    }
        
        private let regionRadius: CLLocationDistance = 1000 // 1km ~ 1 mile = 1.6km
        func zoomMapOn(location: CLLocation)
        {
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius * 8.0, longitudinalMeters: regionRadius * 8.0)
            mapView.setRegion(coordinateRegion, animated: true)
            
        }

    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta:regoinInMeters , longitudeDelta: regoinInMeters))
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    //some coordinations
    let GGcompany = Venue(title: "GGcompany", price: "Fix price € 20,00", coordinate: CLLocationCoordinate2D(latitude: 51.448289, longitude: 5.490989), image: UIImage(named: "screwD")!)
    
    let James_Company = Venue(title: "James Company", price: "Fix price € 15,00", coordinate: CLLocationCoordinate2D(latitude: 51.447073, longitude: 5.495439),image: UIImage(named: "screwD")!)
    
    let Alex_bike = Venue(title: "Alex biker", price: "Fix price € 20,00", coordinate: CLLocationCoordinate2D(latitude: 51.452876, longitude: 5.496176),image: UIImage(named: "screwD")!)
    
    let Starbucks_bike = Venue(title: "Starbucks bike", price: "Fix price € 15,00", coordinate: CLLocationCoordinate2D(latitude: 51.449508, longitude: 5.479961),image: UIImage(named: "screwD")!)
    
    
    
    
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
    
extension FixMapViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last!
        self.mapView.showsUserLocation = true
        zoomMapOn(location: location)
    }
}
    
    
extension FixMapViewController : MKMapViewDelegate
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
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            
            //forImage
            let imageview = UIImageView.init(frame:CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 30, height: 30)))
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


    


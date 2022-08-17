//
//  MapView.swift
//  InstagramSUI
//
//  Created by Lavanya Sai Kumar Kantubhukta on 08/04/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    let pmobj = mylocationPM()
    @State var lat : CLLocationDegrees = 28.7
    @State var long : CLLocationDegrees = 77.0
    @State var annotation = MKPointAnnotation()
    @State var region =
        
          MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 28.7 ,  longitude: 77.0),span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
    @State var poi : [AnnotatedItem ] = []
    
    var body: some View {
        
        
        VStack {
            
            HStack{
                Text("Post Location")
                    .font(.system(size: 30))
            }
            Map(coordinateRegion: $region, showsUserLocation: false, annotationItems: poi) {item in
               // MapMarker(coordinate: item.coordinate, tint: .red)
                
                
                MapAnnotation(coordinate: item.coordinate) {
    //                RoundedRectangle(cornerRadius: 5.0)
    //                    .stroke(Color.purple, lineWidth: 4.0)
    //                    .frame(width: 30, height: 30)
                    Image(systemName: "heart")
                        .foregroundColor(.red)
                }
                
            }.frame(width: Swidth, height: Sheight / 2)
                
            
                .onAppear {
                    
                    pmobj.checkIfLocationServicesEnabled()
                    if let lat = pmobj.locationManager?.location?.coordinate.latitude {
                        self.lat = lat
                        
                    }
                    if let long = pmobj.locationManager?.location?.coordinate.longitude {
                        self.long = long
                    }
                    let coordinates = CLLocationCoordinate2D(latitude: lat ,  longitude: long)
                    self.region =     MKCoordinateRegion(center: coordinates ,span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                    
                    
                    self.annotation.coordinate = coordinates
                    self.annotation.title =  "you are here"
                    
                    poi.append(AnnotatedItem(name: "You are here", coordinate: coordinates))
                     
                    
            }
        }
    }
    
    
    func addCustomLocation() {
        
        
        let coordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(CLLocationDegrees(lat as CLLocationDegrees)), longitude: long as CLLocationDegrees)
        
        //get user location
       // let userLocation = mapView.userLocation
         
        
    }
    
    struct AnnotatedItem : Identifiable {
        
        let id = UUID()
        var name : String
        var coordinate : CLLocationCoordinate2D
    }
    
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
        
    
    }
}

final class mylocationPM :NSObject, ObservableObject , CLLocationManagerDelegate{
    
    var locationManager : CLLocationManager?
    
    func checkIfLocationServicesEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            
            
          
            
        }else {
            
            print("location services are off")
        }
        
    }
    
   private func checkLocAuthorisation() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
       
            
            
        case .notDetermined: //ask for permisson
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted ")
        case .denied:
            print("denied needs to be changed in app settings")
        case .authorizedAlways,
          .authorizedWhenInUse:
            break
        @unknown default:
            break
        }

        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocAuthorisation()
    }
    
    
    
}




 

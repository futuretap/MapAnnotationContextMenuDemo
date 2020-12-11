//
//  ViewController.swift
//  MapAnnotationContextMenuDemo
//
//  Created by Ortwin Gentz on 03.12.18.
//  Copyright © 2018 FutureTap GmbH. All rights reserved.
//

import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

	@IBOutlet weak var mapView: MKMapView!
	let markerAnnotation = MKPointAnnotation()
	let pinAnnotation = MKPointAnnotation()

	override func viewDidLoad() {
		super.viewDidLoad()
		mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "dot")
		mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: "pin")

		markerAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.8, longitude: -74)
		markerAnnotation.title = "Point Annotation"
		mapView.addAnnotation(markerAnnotation)

		pinAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.75, longitude: -74)
		pinAnnotation.title = "Pin Annotation"
		mapView.addAnnotation(pinAnnotation)

		mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.8, longitude: -74), span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
	}
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		let view: MKAnnotationView
		if annotation as! NSObject == markerAnnotation {
			view = mapView.dequeueReusableAnnotationView(withIdentifier: "dot", for: annotation)
		} else {
			view = mapView.dequeueReusableAnnotationView(withIdentifier: "pin", for: annotation)
		}
		view.addInteraction(UIContextMenuInteraction(delegate: self))
		return view
	}
}

extension ViewController: UIContextMenuInteractionDelegate {
	func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
		return UIContextMenuConfiguration(identifier: nil,
										  previewProvider: nil) { _ -> UIMenu? in
			UIMenu(title: "", children: [
				UIAction(title: "Share",
						 image: UIImage(systemName: "square.and.arrow.up"),
						 identifier: nil,
						 handler: { (action) in
							// action
						 })
			])
		}
	}
}

//
//  ViewController.h
//  map
//
//  Created by mac on 16/6/6.
//  Copyright © 2016年 zhiyou.100. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;
@import MapKit;

@interface ViewController : UIViewController
{
    MKMapView *_mapView;
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
    UITextField *textF;
}

@end


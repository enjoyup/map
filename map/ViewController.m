//
//  ViewController.m
//  map
//
//  Created by mac on 16/6/6.
//  Copyright © 2016年 zhiyou.100. All rights reserved.
//

#import "ViewController.h"
#import "CustomAnotation.h"
@interface ViewController ()<MKMapViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //需配置两个描述信息
    //在plist里面:NSLocationAlwaysUsageDescription---和--NSLocationWhenInUseUsageDescription

    _locationManager=[[CLLocationManager alloc]init];
    [_locationManager requestAlwaysAuthorization];
    [_locationManager startUpdatingLocation];
    
    _mapView=[[MKMapView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.view addSubview:_mapView];
    _mapView.mapType=MKMapTypeStandard;
    _mapView.showsUserLocation=YES;
    _mapView.scrollEnabled=YES;
    _mapView.delegate=self;
    _mapView.userTrackingMode=MKUserTrackingModeFollow;
    
    textF=[[UITextField alloc]initWithFrame:CGRectMake(100, 40, 200, 40)];
    textF.borderStyle=UITextBorderStyleRoundedRect;
    [_mapView addSubview:textF];
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(320, 40, 80, 40)];
    button.backgroundColor=[UIColor blueColor];
    
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:button];
    
    }
-(void)buttonAction
{
    NSLog(@"======");
    _geocoder=[[CLGeocoder alloc]init];
    [_geocoder geocodeAddressString:textF.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error===%@",error);
            return;
        }
        [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            CLLocationDegrees lat=obj.location.coordinate.latitude;
//            CLLocationDegrees longitude=obj.location.coordinate.longitude;
//            NSLog(@"lat==%f,longitude==%f",lat,longitude);
            CLLocationCoordinate2D center= CLLocationCoordinate2DMake(obj.location.coordinate.latitude, obj.location.coordinate.longitude);
            MKCoordinateSpan span = MKCoordinateSpanMake(50, 62);
            MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
            [_mapView setRegion:region animated:YES];
            
        }];
    }];

}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pin=(MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotation"];
    if (!pin) {
        pin=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotation"];
        pin.pinColor=MKPinAnnotationColorRed;//修改大头针颜色
        pin.animatesDrop=YES;//动画形式显示
        pin.canShowCallout=YES;//显示pop视图
    }
    return pin;
}
//- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotation"];
//    if (!annotationView) {
//        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotation"];
//        //修改大头针的颜色
//        annotationView.pinColor = MKPinAnnotationColorRed;
//        //以动画的效果显示大头针
//        annotationView.animatesDrop = YES;
//        //显示pop视图
//        //annotationView.canShowCallout = YES;
//    }
//    //*/
//    
//    return annotationView;
//
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

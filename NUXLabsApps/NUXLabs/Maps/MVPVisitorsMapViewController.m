#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "NUXLabs/Maps/MVPVisitorsMapViewController.h"

#import <GoogleMaps/GoogleMaps.h>

#import <QuartzCore/QuartzCore.h>

@implementation MVPVisitorsMapViewController {
  GMSMapView *mapView_;
  GMSMarker *lasVegasMarker_;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:32.8245525
                                                          longitude:-117.0951632
                                                               zoom:4];
  mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];

  GMSMarker *sanDiegoMarker = [[GMSMarker alloc] init];
  sanDiegoMarker.position = CLLocationCoordinate2DMake(32.8245525, -117.0951632);
  sanDiegoMarker.map = mapView_;

  lasVegasMarker_ = [[GMSMarker alloc] init];
  lasVegasMarker_.position = CLLocationCoordinate2DMake(36.125, -115.175);
  lasVegasMarker_.map = mapView_;

  mapView_.delegate = self;
  self.view = mapView_;
}

#pragma mark - GMSMapViewDelegate

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
  if (marker == lasVegasMarker_) {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon"]];
  }

  return nil;
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
  // Animate to the marker
  [CATransaction begin];
  [CATransaction setAnimationDuration:3.f];  // 3 second animation

  GMSCameraPosition *camera =
      [[GMSCameraPosition alloc] initWithTarget:marker.position
                                           zoom:8
                                        bearing:50
                                   viewingAngle:60];
  [mapView animateToCameraPosition:camera];
  [CATransaction commit];

  if (marker == lasVegasMarker_ &&
      mapView.selectedMarker != lasVegasMarker_) {
    return NO;
  }

  // The Tap has been handled so return YES
  return YES;
}

@end

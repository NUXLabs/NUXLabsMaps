#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "NUXLabs/Maps/MeetingsMapViewController.h"

#import <GoogleMaps/GoogleMaps.h>

@implementation MeetingsMapViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:32.8245525
                                                          longitude:-117.0951632
                                                               zoom:10];
  self.view = [GMSMapView mapWithFrame:CGRectZero camera:camera];
}

@end

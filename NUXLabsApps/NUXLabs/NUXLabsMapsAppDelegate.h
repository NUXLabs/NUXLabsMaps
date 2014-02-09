#import <UIKit/UIKit.h>

@interface NUXLabsMapsAppDelegate : UIResponder <
    UIApplicationDelegate,
    UISplitViewControllerDelegate>

@property(strong, nonatomic) UIWindow *window;
@property(strong, nonatomic) UINavigationController *navigationController;
@property(strong, nonatomic) UISplitViewController *splitViewController;

/**
 * If the device is an iPad, this property controls the map displayed in the
 * right side of its split view controller.
 */
@property(strong, nonatomic) UIViewController *map;

@end

#import <UIKit/UIKit.h>

@class NUXLabsMapsAppDelegate;

@interface NUXLabsMapsMasterViewController : UITableViewController <
    UISplitViewControllerDelegate,
    UITableViewDataSource,
    UITableViewDelegate>

@property (nonatomic, assign) NUXLabsMapsAppDelegate *appDelegate;

@end

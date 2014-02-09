#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "NUXLabs/NUXLabsMapsMasterViewController.h"

#import "NUXLabs/Maps/Maps.h"
#import "NUXLabs/NUXLabsMapsAppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation NUXLabsMapsMasterViewController {
  NSArray *maps_;
  NSArray *mapSections_;
  BOOL isPhone_;
  UIPopoverController *popover_;
  UIBarButtonItem *mapsButton_;
  __weak UIViewController *controller_;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  isPhone_ = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;

  if (!isPhone_) {
    self.clearsSelectionOnViewWillAppear = NO;
  } else {
    UIBarButtonItem *backButton =
    [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", @"Back")
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
  }

  self.title = NSLocalizedString(@"NUX Labs Maps", @"NUX Labs Maps");
  self.title = [NSString stringWithFormat:@"%@", self.title];

  self.tableView.autoresizingMask =
      UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
  self.tableView.delegate = self;
  self.tableView.dataSource = self;

  mapSections_ = [Maps loadSections];
  maps_ = [Maps loadMaps];

  if (!isPhone_) {
    [self loadMap:0 atIndex:0];
  }
}

#pragma mark - UITableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return mapSections_.count;
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForHeaderInSection:(NSInteger)section {
  return 35.0;
}

- (NSString *)tableView:(UITableView *)tableView
    titleForHeaderInSection:(NSInteger)section {
  return [mapSections_ objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return [[maps_ objectAtIndex: section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"Cell";
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:cellIdentifier];

    if (isPhone_) {
      [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
  }

  NSDictionary *map = [[maps_ objectAtIndex:indexPath.section]
                        objectAtIndex:indexPath.row];
  cell.textLabel.text = [map objectForKey:@"title"];
  cell.detailTextLabel.text = [map objectForKey:@"description"];

  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // The user has chosen a sample; load it and clear the selection!
  [self loadMap:indexPath.section atIndex:indexPath.row];
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController
     willHideViewController:(UIViewController *)viewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)popoverController {
  popover_ = popoverController;
  mapsButton_ = barButtonItem;
  mapsButton_.title = NSLocalizedString(@"Maps", @"Maps");
  mapsButton_.style = UIBarButtonItemStyleDone;
  [self updateMapsButton];
}

- (void)splitViewController:(UISplitViewController *)splitController
       willShowViewController:(UIViewController *)viewController
    invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
  popover_ = nil;
  mapsButton_ = nil;
  [self updateMapsButton];
}

#pragma mark - Private methods

- (void)loadMap:(NSUInteger)section
         atIndex:(NSUInteger)index {
  NSDictionary *map = [[maps_ objectAtIndex:section] objectAtIndex:index];
  UIViewController *controller =
      [[[map objectForKey:@"controller"] alloc] init];
  controller_ = controller;

  if (controller != nil) {
    controller.title = [map objectForKey:@"title"];

    if (isPhone_) {
      [self.navigationController pushViewController:controller animated:YES];
    } else {
      [self.appDelegate setMap:controller];
      [popover_ dismissPopoverAnimated:YES];
    }

    [self updateMapsButton];
  }
}

// This method is invoked when the left 'back' button in the split view
// controller on iPad should be updated (either made visible or hidden).
// It assumes that the left bar button item may be safely modified to contain
// the maps button.
- (void)updateMapsButton {
  controller_.navigationItem.leftBarButtonItem = mapsButton_;
}

@end

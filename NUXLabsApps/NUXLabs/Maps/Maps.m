#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "NUXLabs/Maps/Maps.h"

// Event Maps
#import "NUXLabs/Maps/MeetingsMapViewController.h"

// Volunteer Maps
#import "NUXLabs/Maps/ChapterOfficersMapViewController.h"
#import "NUXLabs/Maps/MVPVisitorsMapViewController.h"

@implementation Maps

+ (NSArray *)loadSections {
  return @[@"Event Maps", @"Volunteer Maps"];
}

+ (NSArray *)loadMaps {
  NSArray *eventMaps =
  @[[self newMap:[MeetingsMapViewController class]
        withTitle:@"Meetings"
   andDescription:nil],
  ];

  NSArray *volunteerMaps =
  @[[self newMap:[ChapterOfficersMapViewController class]
        withTitle:@"Chapter Officers"
   andDescription:nil],
    [self newMap:[MVPVisitorsMapViewController class]
        withTitle:@"MVP Visitors"
   andDescription:nil],
  ];

  return @[eventMaps, volunteerMaps];
}

+ (NSDictionary *)newMap:(Class) class
                withTitle:(NSString *)title
           andDescription:(NSString *)description {
  return [[NSDictionary alloc] initWithObjectsAndKeys:class, @"controller",
          title, @"title", description, @"description", nil];
}
@end

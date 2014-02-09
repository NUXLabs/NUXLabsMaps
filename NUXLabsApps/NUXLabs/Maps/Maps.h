#import <Foundation/Foundation.h>

@interface Maps : NSObject
+ (NSArray *)loadSections;
+ (NSArray *)loadMaps;
+ (NSDictionary *)newMap:(Class) class
                withTitle:(NSString *)title
           andDescription:(NSString *)description;
@end

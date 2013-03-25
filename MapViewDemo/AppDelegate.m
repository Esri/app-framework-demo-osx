#import "AppDelegate.h"

@interface AppDelegate () <AGSPortalDelegate, AGSWebMapDelegate>{
    AGSPortal *_portal;
    AGSWebMap *_webmap;
}
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

-(void)awakeFromNib{
    _portal = [[AGSPortal alloc]initWithURL:[NSURL URLWithString:@"http://www.arcgis.com"] credential:nil];
    _portal.delegate = self;
}

#pragma mark portal delegate

-(void)portalDidLoad:(AGSPortal *)portal{
    _webmap = [AGSWebMap webMapWithItemId:@"1966ef409a344d089b001df85332608f" portal:_portal];
    _webmap.delegate = self;
}

#pragma mark webmap delegate

-(void)webMapDidLoad:(AGSWebMap *)webMap{
    [_webmap openIntoMapView:_mapView];
}

#pragma mark actions

@end

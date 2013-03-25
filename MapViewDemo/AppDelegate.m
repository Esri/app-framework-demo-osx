#import "AppDelegate.h"
#import "EAFKit.h"

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
    [EAFAppContext sharedAppContext].mapView = _mapView;
    _portal = [[AGSPortal alloc]initWithURL:[NSURL URLWithString:@"http://www.arcgis.com"] credential:nil];
    _portal.delegate = self;
}

#pragma mark portal delegate

-(void)portalDidLoad:(AGSPortal *)portal{
    [EAFAppContext sharedAppContext].portal = _portal;
    _webmap = [AGSWebMap webMapWithItemId:@"1966ef409a344d089b001df85332608f" portal:_portal];
    _webmap.delegate = self;
}

#pragma mark webmap delegate

-(void)webMapDidLoad:(AGSWebMap *)webMap{
    [EAFAppContext sharedAppContext].webMap = _webmap;
    [_webmap openIntoMapView:_mapView];
}

#pragma mark actions

@end

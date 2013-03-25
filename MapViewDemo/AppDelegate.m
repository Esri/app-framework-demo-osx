#import "AppDelegate.h"
#import "EAFKit.h"

@interface AppDelegate () <AGSPortalDelegate, AGSWebMapDelegate, AGSMapViewTouchDelegate>{
    AGSPortal *_portal;
    AGSWebMap *_webmap;
    EAFTOCViewController *_tocVC;
    NSViewController *_lastVCShown;
    EAFPopupManagerViewController *_popupMgrVC;
    EAFBasemapsViewController *_basemapsVC;
    NSPopover *_popover;
}
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

-(void)awakeFromNib{
    [EAFAppContext sharedAppContext].mapView = _mapView;
    _mapView.touchDelegate = self;
    
    _portal = [[AGSPortal alloc]initWithURL:[NSURL URLWithString:@"http://www.arcgis.com"] credential:nil];
    _portal.delegate = self;
}

#pragma mark view swapping

-(void)showInLeftContainer:(NSViewController*)vc{
    if ([_lastVCShown respondsToSelector:@selector(deactivate)]){
        id deac = _lastVCShown;
        [deac deactivate];
    }
    if (_lastVCShown){
        [_lastVCShown.view removeFromSuperview];
    }
    _lastVCShown = vc;
    if ([_lastVCShown respondsToSelector:@selector(activate)]){
        id activ = _lastVCShown;
        [activ activate];
    }
    [vc eaf_addToContainerWithConstraints:_leftContainer];
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

-(void)didOpenWebMap:(AGSWebMap *)webMap intoMapView:(AGSMapView *)mapView{
    [self contentsAction:nil];
}

#pragma mark mapview touch delegate

-(void)mapView:(AGSMapView *)mapView didClickAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint graphics:(NSDictionary *)graphics{
    
    if (![_webmap hasPopupsDefined]){
        return;
    }
    
    if (!_popupMgrVC){
        _popupMgrVC  = [[EAFPopupManagerViewController alloc]init];
    }
    
    if (![_popupMgrVC fetchPopupsForPoint:mappoint]){
        return;
    }
    
    [self showInLeftContainer:_popupMgrVC];
}

#pragma mark actions

- (IBAction)contentsAction:(id)sender {
    if (!_tocVC){
        _tocVC = [[EAFTOCViewController alloc]init];
    }
    [self showInLeftContainer:_tocVC];
}

- (IBAction)basemapsAction:(NSButton *)sender {
    if (!_basemapsVC){
        _basemapsVC = [[EAFBasemapsViewController alloc]init];
    }
    _popover = [[NSPopover alloc]init];
    _popover.behavior = NSPopoverBehaviorTransient;
    _popover.contentViewController = _basemapsVC;
    [_popover showRelativeToRect:sender.bounds ofView:sender preferredEdge:NSMaxYEdge];
}
@end



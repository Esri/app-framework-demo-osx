// Copyright 2013 ESRI
//
// All rights reserved under the copyright laws of the United States
// and applicable international laws, treaties, and conventions.
//
// You may freely redistribute and use this sample code, with or
// without modification, provided you include the original copyright
// notice and use restrictions.
//
// See the use restrictions at http://help.arcgis.com/en/sdk/10.0/usageRestrictions.htm
//


#import "AppDelegate.h"

@interface AppDelegate (){
    
}
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    // set the delegate for the map view
    self.mapView.layerDelegate = self;
    
    //create an instance of a tiled map service layer
    AGSTiledMapServiceLayer *tiledLayer = [[AGSTiledMapServiceLayer alloc] initWithURL:[NSURL URLWithString:kTiledMapServiceURL]];
    
    //Add it to the map view
    [self.mapView addMapLayer:tiledLayer withName:@"Tiled Layer"];
    
    //release to avoid memory leaks
    
    //create an instance of a dynmaic map layer
    self.dynamicLayer = [[AGSDynamicMapServiceLayer alloc] initWithURL:[NSURL URLWithString:kDynamicMapServiceURL]];
    
    //set visible layers
    self.dynamicLayer.visibleLayers = [NSArray arrayWithObjects:[NSNumber numberWithInt:2], nil];
    
    //name the layer. This is the name that is displayed if there was a property page, tocs, etc...
    [self.mapView addMapLayer:self.dynamicLayer withName:@"Dynamic Layer"];
    
    //set transparency
    self.dynamicLayer.opacity = 0.2;
}

- (IBAction)opacitySliderValueChanged:(id)sender {
    // set the layer's opacity based on the value of the slider
    NSSlider *slider = (NSSlider*)sender;    
    self.dynamicLayer.opacity = [slider doubleValue];
}

#pragma mark AGSMapViewLayerDelegate methods

-(void) mapViewDidLoad:(AGSMapView*)mapView {
    
    // comment to disable the GPS on start up
    [self.mapView.locationDisplay startDataSource];
    self.mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanModeDefault;
}

@end

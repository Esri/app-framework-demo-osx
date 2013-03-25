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

#import <Cocoa/Cocoa.h>

//contants for data layers
#define kTiledMapServiceURL @"http://server.arcgisonline.com/ArcGIS/rest/services/ESRI_StreetMap_World_2D/MapServer"
#define kDynamicMapServiceURL @"http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Specialty/ESRI_StateCityHighway_USA/MapServer"

//Set up constant for predefined where clause for search
#define kLayerDefinitionFormat @"STATE_NAME = '%@'"

@interface AppDelegate : NSObject <NSApplicationDelegate, AGSMapViewLayerDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet AGSMapView *mapView;
@property (strong) AGSDynamicMapServiceLayer *dynamicLayer;

- (IBAction)opacitySliderValueChanged:(id)sender;
@end

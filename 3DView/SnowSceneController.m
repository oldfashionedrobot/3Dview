//
//  ViewController.m
//  3DView
//
//  Created by Sanjeev Nayak on 9/24/14.
//  Copyright (c) 2014 Sanbeev. All rights reserved.
//

#import "SnowSceneController.h"

@interface SnowSceneController ()
    #define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
    #define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

    @property (nonatomic, strong) IBOutlet UIPanGestureRecognizer *panRecognizer;
@end

@implementation SnowSceneController

SCNNode *cameraNode;
double pitchRestrict = 85;

- (IBAction)scrolly:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint delta = [recognizer translationInView:self.view];
    
    double pitch = cameraNode.eulerAngles.x + ( delta.y * 0.001 );
    
    // keep from flipping over
    if( RADIANS_TO_DEGREES(pitch) > pitchRestrict ) pitch = DEGREES_TO_RADIANS( pitchRestrict );
    else if( RADIANS_TO_DEGREES(pitch) < -pitchRestrict ) pitch = DEGREES_TO_RADIANS( -pitchRestrict );
    
    cameraNode.eulerAngles = SCNVector3Make( pitch, cameraNode.eulerAngles.y + ( delta.x * 0.001 ), 0 );
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SCNView *sceneView = (SCNView *)self.view;
    sceneView.backgroundColor = [UIColor blueColor];

    // Create the scene and get the root
    sceneView.scene = [SCNScene scene];
    SCNNode *root = sceneView.scene.rootNode;
    
    // Add sphere thing
    SCNScene *geo = [SCNScene sceneNamed:@"sphere.dae"];
    [root addChildNode:geo.rootNode];
    
    // Create a camera
    SCNCamera *camera = [SCNCamera camera];
    camera.xFov = 45;
    camera.yFov = 45;
    cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 0, 0);
    [root addChildNode:cameraNode];
    
    // Add light
    SCNLight *light = [SCNLight light];
    light.type = SCNLightTypeAmbient;
    root.light = light;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@implementation ViewController
{
    IBOutlet UIView *canvasView;
    CALayer *imageLayer;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    UIColor *borderColor = [UIColor redColor];
    canvasView.layer.borderWidth = 1.0;
    canvasView.layer.borderColor = borderColor.CGColor;
    
    imageLayer = [CALayer layer];
    imageLayer.bounds = CGRectMake(0, 0, 160, 160);
    imageLayer.position = CGPointMake(160, 160);
    UIImage *image = [UIImage imageNamed:@"UshioLogo.png"];
    imageLayer.contents = (id)image.CGImage;
    
    [canvasView.layer addSublayer:imageLayer];
}
static float remapf(float value, float inputMin, float inputMax, float outputMin, float outputMax)
{
    return (value - inputMin) * ((outputMax - outputMin) / (inputMax - inputMin)) + outputMin;
}
static CATransform3D CATransform3DMakeShearY(float rotation)
{
    CATransform3D shear = {
        1.0, 0.0, 0.0, 0.0,
        tanf(rotation), 1.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        0.0, 0.0, 0.0, 1.0,
    };
    return shear;
}
static CATransform3D CATransform3DMakeShearX(float rotation)
{
    CATransform3D shear = {
        1.0, tanf(rotation), 0.0, 0.0,
        0.0, 1.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        0.0, 0.0, 0.0, 1.0,
    };
    return shear;
}
- (IBAction)onSliderChanged:(UISlider *)sender
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    float mapped = remapf(sender.value, 0.0f, 1.0f, - M_PI * 0.5, M_PI * 0.5);
    imageLayer.transform = CATransform3DMakeShearY(mapped);
    [CATransaction commit];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

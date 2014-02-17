PYPopoverView
=============

This is a simple popover view that will resize it's height based on the content.

###How to use it:

This will position the pointy triangle on the popover to point at 100.0 and 300.0 with a maxium width of 50.0 while the height is determined by the popover view to fit the content.

```objective-c
PYPopoverView* popover = [[PYPopoverView alloc] initWithFrame:CGRectMake(100, 300, 50, 0) andText:@"I am a popover :)"];
popover.borderColor = [UIColor grayColor];
popover.borderRadius = 6.0f;
```

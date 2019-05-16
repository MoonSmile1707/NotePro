# Draw Basics

<hr/>

The `SkCanvasView` occupies the entire content area of the page. You can alternatively combine an `SKCanvasView` with other Xamarin.Forms `View` derivatives, as you'll see in other examples.

The `PaintSurface` event handler is where you do all your drawing. This method can be called multiple times while your program is running, so it should maintain all the information necessary to recreate the praphics display:

```csharp
void OnCanvasViewPaintSurface(object sender, SKPaintSurfaceEventArgs args)
{
    ...
}
```

The [SkPaintSurfaceEventArgs](https://docs.microsoft.com/dotnet/api/skiasharp.views.forms.skpaintsurfaceeventargs) object that accompanies the event has two properties:

- [Info](https://docs.microsoft.com/dotnet/api/skiasharp.views.forms.skpaintsurfaceeventargs.info#SkiaSharp_Views_Forms_SKPaintSurfaceEventArgs_Info) of type [SKImageInfo](https://docs.microsoft.com/dotnet/api/skiasharp.skimageinfo).
- [Surfae](https://docs.microsoft.com/dotnet/api/skiasharp.views.forms.skpaintsurfaceeventargs.surface#SkiaSharp_Views_Forms_SKPaintSurfaceEventArgs_Surface) of type [SKSurface](https://docs.microsoft.com/dotnet/api/skiasharp.sksurface).

The `SKImageInfo` structure contains information about the drawing surface, most importantly, its width and height in pixels. The `SKSurface` object represents the drawing surface itself.

The most important property of `SKSurface` is [Canvas](https://docs.microsoft.com/dotnet/api/skiasharp.sksurface.canvas#SkiaSharp_SKSurface_Canvas) of type [SKCanvas](https://docs.microsoft.com/dotnet/api/skiasharp.skcanvas). This class is graphics drawing context that you use to perform the actual drawing. The `SKCanvas` object encapsulates a graphics state, which includes graphics transforms and clipping.

To specify the color and other characteristic of the line, you create and initialize an [SKPaint](https://docs.microsoft.com/dotnet/api/skiasharp.skpaint) object:

```csharp
void OnCanvasViewPaintSurface(object sender, SKPaintSurfaceEventArgs args)
{
    ...
    SKPaint paint = new SKPaint
    {
        Style = SKPaintStyle.Stroke,
        Color = Color.Red.ToSKColor(),
        StrokeWidth = 25
    };
    ...
}
```

The [Style](https://docs.microsoft.com/dotnet/api/skiasharp.skpaint.style#SkiaSharp_SKPaint_Style) prperty indicates that you want to stroke a line(in this case the outline of the circle) rather than fill the interior. The three members of the [SKPaintStyle](https://docs.microsoft.com/dotnet/api/skiasharp.skpaintstyle) enumeration are as follows:

- [Fill](https://docs.microsoft.com/dotnet/api/skiasharp.skpaintstyle#SkiaSharp_SKPaintStyle_Fill)
- [Stroke](https://docs.microsoft.com/dotnet/api/skiasharp.skpaintstyle#SkiaSharp_SKPaintStyle_Stroke)
- [StrokeAndFill](https://docs.microsoft.com/dotnet/api/skiasharp.skpaintstyle#SkiaSharp_SKPaintStyle_StrokeAndFill)

The default is `Fill`. Use the third option to stroke the line and fill the interior with the same color.

Set the [Color](https://docs.microsoft.com/dotnet/api/skiasharp.skpaint.color#SkiaSharp_SKPaint_Color) property to a value of type [SKColor](https://docs.microsoft.com/dotnet/api/skiasharp.skcolor). One way to get an `SKColor` value is by converting a Xamarin.Forms `Color` value to an `SKColor` value using the extension method [ToSKColor](https://docs.microsoft.com/dotnet/api/skiasharp.views.forms.extensions.toskcolor). The [Extensions](https://docs.microsoft.com/dotnet/api/skiasharp.views.forms.extensions) class in the `SkiaSharp.Views.Forms` namespace includes other methods that convert between Xamarin.Forms values and SkiaSharp values.

The [StrokeWidth](https://docs.microsoft.com/dotnet/api/skiasharp.skpaint.strokewidth#SkiaSharp_SKPaint_StrokeWidth) property indicates the thickness of the line. Here it's set to 25 pixels.

<hr/>
Get more information at [here](https://docs.microsoft.com/en-us/xamarin/xamarin-forms/user-interface/graphics/skiasharp/basics/circle).

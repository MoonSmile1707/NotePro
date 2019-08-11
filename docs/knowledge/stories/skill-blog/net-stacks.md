# .NET Technology Stacks for Windows Desktop Development

In this article, we're going to take a look at the following technologies:

- Win32 and COM
- WinForms
- Windows Presentation Framework (WPF)
- Universal Windows Platform (UWP)
- Electron(.NET)
- Avalonia

<hr/>

## Win32 and COM

Win32 has been introduced in late 1995 with the release of Windows 95 and is available in all following Windows releases including Windows 10.

Modernizing an applixation written using C++ and the Win32 APIs is a hard task. I do not know about anything alse than rewriting the entire application using another technology stack. Most newer technologies require either Visual Basic .NET or more often C# as the programming language.

## Windows Forms(WinForms)

WinForms is the Windows desktip technology stack introduced with the .NET Framework in 2002 to make desktop development much simpler. After about 15 yearsof closed sorce development, Microsoft announced to open-source WinForms on December 4th, 2018.

WinForms allows the developer to get results quickly. Visual Studio has a built-in editor which enables us to drag and drop controls from the toolbar onto the dialogs. By double-clicking onto the controls on the dialog, Visual Studio generated click handlers in the code which allow us to write the application logic.

The advantages of WinForms are obvious: Rapid prototying, gaining fast results and the opportunity to work with a graphical editor in Visual Studio to crete the use interfaces. WinForms apps run on all Windows computers with an installed .NET Framework.

The downsides of WinForms are the limiteddesign options, the close relationship with Visual Studio which makes application development outside Visual Studio nearly impossible, and generated code which can be a pain using version control systems when multiple developers collaborate on the smae project.

## Windows Presentation Framework (WPF)

With the release of .NET Framework 3.0 in 2006 Microsoft introduced the WPF as an alternative to WinForms for Windows desktop development.

The main difference between Windows and WPF is the design language. For WinForms apps, we use the graphicla designer, and for WPF applixations we use XAML as a markup language to describe our user interfaces.

The advantages are obvious. Using an XML-like languages developer have full control over the structure of their user interfaces. Custom designs were enabled by WPF and implementing custom controls to build richer user exeriences became possible.

Using the data-binding mechanism and utilizing the MVVM design pattern WPF applications allow develipers to split their code between user interface design code and business logic. Application logic can and should be written in class libraries with no dependency on any user interface framework. It allows for more maintainable and reusable code.

On the other side, development becomes much more demanding and requires more knowledge. Gaining results can be hard in the beginning, and there are always multiple ways to solve a prblem. WinForms is often limited by forces you to a more straightforward solution on the other side.

## Universal Windows Platform

UWP applications aer a modern alternative to WPF and WinForms applixations. UWP replaces the Windows Runtime (WinRT) and requires Windows 10.

UWP aps can be developed either in C# using XAML which feels a lot like writing a WPF application (with a few restrictions) or using JS and HTML.

## Electron (.NET)

Electron allows developing desktop applixations with web technologies (HTML, CSS, and JS). Electron runs your applixation on Chromium as a node application with means that electron opens a browser window and lets you run your web application similar to a native desktop application.

The advantage is theat Electron applications are cross-platform and also run on iOS and Linux.

On the downside, we have heavy CPU and RAM usage because the behind the scene running Chromium process consumes a lot of resources.

Electron.NET allows us to develop Electron applications using ASP.NET Core. We can write  C# and have the same APIs as Electron offers to JavaScript developers. In general, Electron.NET coms with the same advantages and disadvantages compared to Electron.

## Avalonia

Avalonia is a cross-platform XAML Framework for .NET Framework, .NET Core and Mono. Avalonia has a similar look like WPF or UWP interface definitions because it utilizes a XAML dialect for the view definitions. It also supports MVVM, data-binding and much more.

Avalonia is new which means that they do not have a lot of legacy code in their framework. Unlike WPF where there is code older than a decade that cannot be removed because of compatibility issues.

<hr/>

Get more information at [here](https://dev.to/claudiobernasconi/net-technology-stacks-for-windows-desktop-development-2kl3?utm_source=additional_box&utm_medium=internal&utm_campaign=regular&booster_org=).


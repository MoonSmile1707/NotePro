# Locate dependencies by using the factory pattern

<hr/>

![6factory](../../../../img-root/6-factory-pattern.png)

The platform-specific code and the cross-platform code share the factory. The factory is defined in your shared code assemply. It's responsible for creating the platform-specific dependency. Only the factory class knows how to create the dependency.

You can create the dependency in the factory in several ways. You might decide to use a delegate or use a partial class. Keep in mind that no matter which option you choose, the dependency must be created in platform-specific code.

## What is a delegate?

A _delegate_ is a data structure that references a method. The method can be a static method or an instance method from a class instance. It's easiest to think of a delegate as something that points to a method.

```csharp
using System;
using System.IO;

delegate bool LoggerMethod();

public class TestDelegate
{
   public static void Main()
   {
      OutputProcess outputProcess = new OutputProcess();
      LoggerMethod loggerCall = outputProcess.SendToLogger;

      if (loggerCall())
         Console.WriteLine("Success!");
      else
         Console.WriteLine("Logger operation failed.");
   }
}

public class OutputProcess
{
   public bool SendToLogger()
   {
        try {
            ...
            return true;
        }
        catch
        {
            ...
            return false;
        }
   }
}
```

## What is Func?

`Func<TResult>` represents a method that has no parameters and returns a valus of the type specified by the `TResult` parameter.

```csharp
using System;
using System.IO;

public class TestDelegate
{
   public static void Main()
   {
      OutputProcess outputProcess = new OutputProcess();
      Func<bool> loggerCall = () => outputProcess.SendToLogger;

      if (loggerCall())
         Console.WriteLine("Success!");
      else
         Console.WriteLine("Logger operation failed.");
   }
}

public class OutputProcess
{
   public bool SendToLogger()
   {
        try {
            ...
            return true;
        }
        catch
        {
            ...
            return false;
        }
   }
}
```

## Create the factory

You're going to use the delegate concept to create the factory. Remember, something must instantiate the dependency. Using a method to instantiate the dependency is a good idea. But you must define the method needs in platform-specific code and not in an abstract class. Because a delegate can point to any method, you can create the delegate in your abstract class and then configure the delegate somewhere else.

```csharp
using System;
using System.Collections.Generic;
using Xamarin.Forms;

namespace MyApplication
{
    public partial class AboutPage : ContentPage
    {
        public AboutPage()
        {
            InitializeComponent();
        }

        void Handle_Clicked(object sender, EventArgs e)
        {
            MessageDialog messageDialog = MessageDialog.Create();
            messageDialog.ShowMessage("About", "Some information ...", "Ok");
        }
    }

    public abstract class MessageDialog
    {
        public static Func<MessageDialog> Create { get; set; }
        public abstract void ShowMessage(string title, string message, string buttonText);
    }
}
```

Because you can reference the staic property from anywhere in your code, you can configure the delegate in your platform-specific code. Let's look at how this configuration will work.

Here's an example for iOS:

```csharp
public partial class AppDelegate : global::Xamarin.Forms.Platform.iOS.FormsApplicationDelegate
{
    public override bool FinishedLaunching(UIApplication application, NSDictionary launchOptions)
    {
        ...
        MessageDialog.Create = () => new MessageDialog_iOS();
        ...
    }
}
```

Here's an example for Android:

```csharp
public partial class AppDelegate : global::Xamarin.Forms.Platform.iOS.FormsApplicationDelegate
{
    public override bool FinishedLaunching(UIApplication application, NSDictionary launchOptions)
    {
        ...
        MessageDialog.Create = () => new MessageDialog_iOS();
        ...
    }
}
```

## What are the advantages of the factory pattern?

The factory pattern has the following advantages:

- The dependency's implementation is hidden from the client. The client doesn't need to know how the dependency is created or where the dependency comes from.
- The pattern is easy to understand.
- You can decide what the implementation should be at runtime and return a specific version based on your environment.

## What are the disadvantages of the factory pattern?

The factory pattern has the following disadvantages:

- The pattern requires a separate "factory" for each abstraction. If you have several factories, your code maintenance will increase.
- Even though the client doesn't knowhow the dependency is created, it still needs to take a dependency against the factory.
- Missing dependencies aren't known until runtime because dependencies are resolved only when the application runs.

<hr/>

Get more information at [here](https://docs.microsoft.com/en-us/learn/modules/explore-cross-platform-design-patterns/6-locate-dependencies-using-the-factory-pattern).

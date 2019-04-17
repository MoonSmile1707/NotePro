# Xamarin.Forms Data Templates

<hr/>

## Introduction

Xamarin.Forms data templates provide the ability to dfine the presentation of data on supported controls. This article provides an introduction to data templates, examining why they are necessary.

## Creating a DataTemplate

Data templates can be created inline, in a [`ResourceDictionary`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.resourcedictionary), or fom a custom type or appropriate Xamarin.Forms cell type. An inline template should be used if there's no need to reuse the data template elsewhere. Alternatively, a data template can be reused by definng it as a custom type, or as a control-level, page-level, or application-level resource.

A [`DataTemplate`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.datatemplate) is used to specify the appearance of data, and typically uses data binding to display data. Its common usage scenario is when displaying data from a collection of objects in a [`ListView`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.listview).

A [`DataTemplate`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.datatemplate) can be used as a value for the following properties:

- [`ListView.HeaderTemplate`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.listview.headertemplate#Xamarin_Forms_ListView_HeaderTemplate)
- [`ListView.FooterTemplate`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.listview.footertemplate#Xamarin_Forms_ListView_FooterTemplate)
- [`ListView.GroupHeaderTemplate`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.listview.groupheadertemplate#Xamarin_Forms_ListView_GroupHeaderTemplate)
- [`ItemsView.ItemTemplate`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.itemsview-1), which is in herited by [`ListView`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.listview).
- [`MultiPage.ItemTemplate`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.multipage-1), which is ingerited by [`CarouselPage`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.carouselpage), [`MasterDetailPage`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.masterdetailpage). and [`TabbedPage`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.tabbedpage).

### Creating an Inline DataTemplate

The elements specified in the `DataTemplate` define the appearance of each cell, as shown in the following XAML code example:

```xml
<ListView Margin="0,20,0,0">
    <ListView.ItemsSource>
        <x:Array Type="{x:Type local:Person}">
            <local:Person Name="Steve" Age="21" Location="USA" />
            <local:Person Name="John" Age="37" Location="USA" />
            <local:Person Name="Tom" Age="42" Location="UK" />
            <local:Person Name="Lucas" Age="29" Location="Germany" />
            <local:Person Name="Tariq" Age="39" Location="UK" />
            <local:Person Name="Jane" Age="30" Location="USA" />
        </x:Array>
    </ListView.ItemsSource>
    <ListView.ItemTemplate>
        <DataTemplate>
            <ViewCell>
                <Grid>
                    ...
                    <Label Text="{Binding Name}" FontAttributes="Bold" />
                    <Label Grid.Column="1" Text="{Binding Age}" />
                    <Label Grid.Column="2" Text="{Binding Location}" HorizontalTextAlignment="End" />
                </Grid>
            </ViewCell>
        </DataTemplate>
    </ListView.ItemTemplate>
</ListView>
```

The child of an inline [`DataTemplate`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.datatemplate) must be of, or derive from, type [`Cell`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.cell). This example uses a [`ViewCell`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.viewcell), which derives from `Cell`. Layout inside the `ViewCell` is managed here by a [`Grid`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.grid). The `Grid` contains three [`Label`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.label) instances that bind their [`Text`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.label.text#Xamarin_Forms_Label_Text) properties to the appropriate properties of each `Person` object in the collection.

### Creating a DataTemplate with a Type

The [`ListView.Itemplate`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.itemsview-1) property can also be set to a [`DataTemplate`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.datatemplate) that's created from a cell type. The advantage og this approach is that the appearance defined by the cell type can be reused by multiple data templates throughout the application. The following XAML code shows an example of this approach:

```xml
<ContentPage xmlns="http://xamarin.com/schemas/2014/forms"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             xmlns:local="clr-namespace:DataTemplates"
             ...>
    <StackLayout Margin="20">
        ...
        <ListView Margin="0,20,0,0">
           <ListView.ItemsSource>
                <x:Array Type="{x:Type local:Person}">
                    <local:Person Name="Steve" Age="21" Location="USA" />
                    ...
                </x:Array>
            </ListView.ItemsSource>
            <ListView.ItemTemplate>
                <DataTemplate>
                    <local:PersonCell />
                </DataTemplate>
            </ListView.ItemTemplate>
        </ListView>
    </StackLayout>
</ContentPage>
```

Here, the [`ListView.ItemTemplate`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.itemsview-1) property is set to a [`DataTemplate`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.datatemplate) that's created from a custom type that defines the cell appearance. The custom type must derive from type [`ViewCell`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.viewcell), as shown in the following code example:

```xml
<ViewCell xmlns="http://xamarin.com/schemas/2014/forms"
          xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
          x:Class="DataTemplates.PersonCell">
     <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="0.5*" />
            <ColumnDefinition Width="0.2*" />
            <ColumnDefinition Width="0.3*" />
        </Grid.ColumnDefinitions>
        <Label Text="{Binding Name}" FontAttributes="Bold" />
        <Label Grid.Column="1" Text="{Binding Age}" />
        <Label Grid.Column="2" Text="{Binding Location}" HorizontalTextAlignment="End" />
    </Grid>
</ViewCell>
```

### Creating a DataTemplate as a Resource

Data templates can also be created as reusable objects in a [`ResourceDictionary`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.resourcedictionary). This is achieved by giving each declaration a unique `x:Key` attribute, which provides it with a descriptive key in the `Resource Dictionary`, as shown in the following XAML code example:

```xml
<ContentPage xmlns="http://xamarin.com/schemas/2014/forms"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             ...>
    <ContentPage.Resources>
        <ResourceDictionary>
            <DataTemplate x:Key="personTemplate">
                 <ViewCell>
                    <Grid>
                        ...
                    </Grid>
                </ViewCell>
            </DataTemplate>
        </ResourceDictionary>
    </ContentPage.Resources>
    <StackLayout Margin="20">
        ...
        <ListView ItemTemplate="{StaticResource personTemplate}" Margin="0,20,0,0">
            <ListView.ItemsSource>
                <x:Array Type="{x:Type local:Person}">
                    <local:Person Name="Steve" Age="21" Location="USA" />
                    ...
                </x:Array>
            </ListView.ItemsSource>
        </ListView>
    </StackLayout>
</ContentPage>
```

## Creating a DataTemplateSelector

A [`DataTemplateSelector`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.datatemplateselector) can be used to choose a [`DataTemplate`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.datatemplate) at runtime based on the value of a data-bound property. This enables multiple `DataTemplate` instances to be applied to the same type of object, to customize the appearance of particular objects. This article demonstrates how to create and consume a `DataTemplateSelector`.

A data template selector is implemented by creating a class that inherits from [`DataTemplateSelector`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.datatemplateselector). The `OnSelectTemplate` method is the overridden to return a particular [`DataTemplate`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.datatemplate), as shown in the following code example:

```csharp
public class PersonDataTemplateSelector : DataTemplateSelector
{
  public DataTemplate ValidTemplate { get; set; }
  public DataTemplate InvalidTemplate { get; set; }

  protected override DataTemplate OnSelectTemplate (object item, BindableObject container)
  {
    return ((Person)item).DateOfBirth.Year >= 1980 ? ValidTemplate : InvalidTemplate;
  }
}
```

#### Limitations

[`DataTemplateSelector`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.datatemplateselector) instances have the following limitations:

- The `DataTemplateSelector` subclass must always return the same template for the same data if queried multiple times.
- The `DataTemplateSelector` subclass must not return another `DataTemplateSelector` subclass.
- The `DataTemplateSelector` sub class must no return new instances of a `DataTemplate` on each call. Instead, the same instance must be returned. Failure to do so will create a memory leak and will disable virtualization.
- On Android, there can be no more than 20 different data templates per `ListView`.

### Consuming a DataTemlateSelector in XAML

In XAML, the `PersonDataTemplateSelector` can be instantiated by declaring it as a resource, as shown in the following code example:

```xml
<ContentPage xmlns="http://xamarin.com/schemas/2014/forms" xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml" xmlns:local="clr-namespace:Selector;assembly=Selector" x:Class="Selector.HomePage">
    <ContentPage.Resources>
        <ResourceDictionary>
            <DataTemplate x:Key="validPersonTemplate">
                <ViewCell>
                   ...
                </ViewCell>
            </DataTemplate>
            <DataTemplate x:Key="invalidPersonTemplate">
                <ViewCell>
                   ...
                </ViewCell>
            </DataTemplate>
            <local:PersonDataTemplateSelector x:Key="personDataTemplateSelector"
                ValidTemplate="{StaticResource validPersonTemplate}"
                InvalidTemplate="{StaticResource invalidPersonTemplate}" />
        </ResourceDictionary>
    </ContentPage.Resources>
  ...
</ContentPage>
```

The `PersonDataTemplateSelector` instance is consumed by assigned it to the [`ListView.Itemplate`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.itemsview-1) property, as shown in the following code example:

```xml
<ListView x:Name="listView" ItemTemplate="{StaticResource personDataTemplateSelector}" />
```

<hr/>

Get more information at [here](https://docs.microsoft.com/en-us/xamarin/xamarin-forms/app-fundamentals/templates/data-templates/)

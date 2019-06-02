# Introduction to Boostrap

<hr/>

Get started with Bootstrap, the world's most popular framework for building responsive, mobile-first, with BootstrapCDN and a template starter page.

## Quick start

looking to quickly add Bootstrap to your project? Use BootstrapCDN, provided for free by the folk at StackPath. Using a package manager or need to download the source files? [Head to the downloads page](https://getbootstrap.com/docs/4.3/getting-started/download/).

## CSS 

Copy-patse the stylesheet `<link>` into your `<head>` before all other stylesheets to load our CSS.

```html
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
```
## JS

Many of our components require the use of JavaScript to function. Specifically, they require [jQuery](https://jquery.com/),[Popper.js](https://popper.js.org/), and our own JavaScript plugins. Place the following `<script>`s near the end of your pages, right before the closing `</body>` tag, to enable them. jQuery must come first, then Popper.js, and then our JavaScript plugins.

We use [jQuery's slim build](https://blog.jquery.com/2016/06/09/jquery-3-0-final-released/), but the full version is also supported.

```html
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
```

Curious which components explicity require jQuery, our JS, and Popper.js? Click the show components link below. If you're at all unsure about the general page structure, keep reading for an example page template.

Our `bootstrap.bundle.js` and `bootstrap.bundle.min.js` include [Popper](https://popper.js.org/), but on [jQuery](https://jquery.com/). For more information about whats included in Bootstrap, please see our [contents](https://getbootstrap.com/docs/4.3/getting-started/contents/#precompiled-bootstrap) section.

Components requiring JavaScript:

- Alerts for dismissing
- Buttons for toggling states and chechbox/radio functionality
- Carousel for all slide behavior, controls and indicators.
- Collapse for toggling visibility of content.
- Dropdowns for displaying and positioning (also requires [Popper.js](https://popper.js.org/))
- Modals for display, positioning and scroll behavior
- Navbar for extending our Collapse pugin to implement responsive behavior
- Tooltip and popovers fr displaying and postioning (also requires [Popper.js](https://popper.js.org/))
- Scrollspy for scroll behavior and navigation updates

## Starter Template

Be sure to have your pages set up with the latest design and development standards. That mean using an HTML 5 doctype and including a viewport meta tag for proper responsive behavior. Put it all together and your pages should look like this:

```html
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <title>Hello, world!</title>
  </head>
  <body>
    <h1>Hello, world!</h1>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  </body>
</html>
```

That's all you need for overall page requirements. Visit the [Layout docs](https://getbootstrap.com/docs/4.3/layout/overview/) or [our official examles](https://getbootstrap.com/docs/4.3/examples/) to start laying out your site's content and components.

## Important globals

Bootstrap employs a handful of important global styles and settings that you'll need to be aware of when using it, all of which are almost exclusively geared towards the *normalization*  of cross browser styles. Let's dive in

## HTML5 doctype

Bootstrap requires the use of the HTML5 doctype. Without it, you'll see som funky incomplete styling, but including it shouldn't cause any considerable diccups.

```html
<!doctype html>
<html lang="en">
  ...
</html>
```

## Responsive meta tag

Bootstrap is developed *mobile first*, a strategy in which we optimize code for mobile devices first and then scale up components as necessary using CSS media queries. To ensure proper rendering  and touch zooming for all devices, **add the responsive viewport meta tag** to you `<head>`.

```html
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
```

You can see an example of this in action in the [starter template](https://getbootstrap.com/docs/4.3/getting-started/introduction/#starter-template).

## Box-sizing

For more straightforward sizing in CSS, we switch the global `boz-sizing` value from `content-box` to `border-box`. This ensure `padding` does not affect the final computed width of an element, but it can cause roblems with some party software like Google Maps and Google Custom Search Engine.

On the rate occasion you need to override it, use something like the following:

```css
.selector-for-some-widget {
  box-sizing: content-box;
}
```

With the above snippet, nested elements- including generated conten via `::before` and `::after` - will all ingerit the specified `box-sizing` for that `.selector-for-some-widget`.

Learn more about [box model and sizing at CSS Tricks](https://css-tricks.com/box-sizing/)

## Reboot

For improved cross-browser rendering, we use [Reboot](https://getbootstrap.com/docs/4.3/content/reboot/) to correct inconsistencies across browsers and devices while providing slightly more opinionated resets to commom HTML elements.

<hr/>

Get more information at [here](https://getbootstrap.com/docs/4.3/getting-started/introduction/)
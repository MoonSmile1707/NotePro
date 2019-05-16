#The CSS Handbook: a handy guide to CSS for developers

<hr/>

##Adding css to an html page

### 1:Using the link tag

The `link` tag is the way to include a CSS file.

```html
<link rel="stylesheet" type="text/css" href="myfile.css" />
```

### 2:using the style tag

Instead of using the `link` tag to point to separate stylesheet containing our CSS, we can add the CSS directly inside a `style` tag. THis is the syntax:

```html
<style>
  ...our CSS...;
</style>
```

### 3:Inline styles

Inline styles are the third way to add CSS to a page. We can add a `style` attribute to an HTML tag, and add CSS into it.

```html
<div style="">...</div>
```

## SELECTORS

we can **_target_** that element using this selector `p`:

```css
p {
  color: yellow;
}
```

Classes are identified using the `.` symbol, while ids using the `#` symbol.

Example using a class:

```html
<p class="dog-name">
  Roger
</p>
.dog-name { color: yellow; }
```

Example using an id:

```html
<p id="dog-name">
  Roger
</p>
#dog-name { color: yellow; }
```

### Cobining selectors

So far we've seen how to target an element, aclass or an id. Let's introduce more powerful selectors.

### Follow the doument tree with selectors

If you have a `span` tag nested inside a `p` tag, you can target that one without applying the style to a `span` tag not included in a `p` tag:

```html
<span>
  Hello!
</span>
<p>
  My dog name is:
  <span class="dog-name">
    Roger
  </span>
</p>
p span { color: yellow; }
```

To make the dependency strict on the first level, you can use the `>` symbol between the two tokens:

```css
p > span {
  color: yellow;
}
```

Direct children will have the style applied:

```html
<p>
  <span>
    This is yellow
  </span>
  <strong>
    <span>
      This is not yellow
    </span>
  </strong>
</p>
```

Adjacent sibling selectors let us style an element only if preceded by a specific element. We do so using the `+` operator:

```css
p + span {
  color: yellow;
}
```

We have a lot more selectors we can use:

- attribute selectors
- pseudo class selectors
- pseudo element selectors

## CASCADE

Cascade is the process, or algotihm, that determines the properties applied to each element on the page. Trying to converge from a list of CSS rules that are defined in various places.

It does so taking in condiseration:

- specificity
- importance
- inheritance
- order in the file

It also takes care of resolving conflicts.

Two or more competing CSS rules for the same property applied to the same element need t be elaborated according to the CSS spec, to determine which one needs to be applied.

Even if you just have one CSS file loaded by your page, there is other CSS that is going to be part of the process. We have the browser(user agent) CSS. Browsers come with a defaults set of rules, all different between browsers.

## SPECIFICITY

Enter specificity. **_The more specfific rule will win._** If two or more rules have the **_same specificity, the one that appears last wins._**

### How to calculate specificity

Specificity is calculated using a convention.

We have 4 slots, and each one of them starts at 0:`0 0 0 0`. The slot at the left is the most important, and the rightmost one is the least important.

#### Slot 1

The first slot, the rightmost one, is the least important.

We increase this value when we have an **_element slector_**. An element is a tag name.

```css
p {
} /* 0 0 0 1 */
span {
} /* 0 0 0 1 */
p span {
} /* 0 0 0 2 */
p > span {
} /* 0 0 0 2 */
div p > span {
} /* 0 0 0 3 */
```

#### Slot 2

The second slot is incremented by 3 things:

- class selectors
- pseudo-class selectors
- attribute selectors

Every time a rule meets one of those, we increment the value of the sencond column from the right.

```css
.name {
} /* 0 0 1 0 */
.users .name {
} /* 0 0 2 0 */
[href$=".pdf"] {
} /* 0 0 1 0 */
:hover {
} /* 0 0 1 0 */
```

Of course slot 2 selectors can be combined with slot 1 selectors:

```css
div .name {
} /* 0 0 1 1 */
a[href$=".pdf"] {
} /* 0 0 1 1 */
.pictures img:hover {
} /* 0 0 2 1 */
```

one nice trick with classes is that you can repeat the same class and increse the specificity.

```css
.name {
} /* 0 0 1 0 */
.name.name {
} /* 0 0 2 0 */
.name.name.name {
} /* 0 0 3 0 */
```

#### Slot 3

Slot 3 holds the most important thing that can affet your CSS specificity in a CSS file: the `id`.

Every element can have an `id` attribute assigned, and we can use that in our stylesheet to target the element.

```css
#name {
} /* 0 1 0 0 */
.user #name {
} /* 0 1 1 0 */
#name span {
} /* 0 1 0 1 */
```

#### Slot 4

Slot 3 is affected by inline styles. Any inline style will have precedence over any rule defined in an external CSS file, or inside the `style` tag in the page header.

```html
<p style="color: red">Test</p>
/* 1 0 0 0 */
```

### Importance

Specificity does not matter if a rule ends with `!important`:

```css
p {
  font-size: 20px !important;
}
```

That rule will take precedence over any rule with more specificity.

### Tips

Generally, `!important` should have no place in your CSS files.

using the `id` attribute to style CSS is also debated a lot, since it has a very high specificity. A good alternative is to use classes insted, which have less specificity, and so they are easier to work with, and they are more powerful (you can have multiple classes for an element, and a class can be reused multiple times).

### Tool s to clculate the specificity

You can use the site [https://specificity.keegan.st/](https://specificity.keegan.st/) to perform the specificity calculation for you automatically.

It's useful especially if you are trying to figure things out, as it can be a nice feedback tool.

## INHERITANCE

### Properties that inherit

Here is a list of the properties that do inherit. This list is non-comprehensive, but those rules are just the most populer ones you'll likely use:

- border-collapse
- border-spacing
- caption-side
- color
- cursor
- direction
- empty-cells
- font-size
- font-family
- font-style
- font-variant
- font-weight
- font-size-adjust
- font-stretch
- font
- letter-spacing
- line-height
- list-style-image
- list-style-position
- list-style-type
- list-style
- orphans
- quotes
- tab-size
- text-align
- text-algn-last
- text-decoration-color
- text-indent
- text-justify
- text-shadow
- text-transform
- visibility
- white-space
- widows
- word-break
- word-spacing

I got it from this [nice Sitepoint article](https://www.sitepoint.com/css-inheritance-introduction/) on CSS inheritance.

### Forcing properties to inherit

What if you have a property that's not inherited by default, and you want it to, in a child?

In the children, yout set the property value to the special keyword `inherit`.

```css
body {
  background-color: yellow;
}
p {
  background-color: inherit;
}
```

### Forcing properties to NOT inherit

On the contrary, you might have a property inherited and you want to avoid so.

You can use the `revert` keyword to revert it. In this case, the value is reverted to the original value the browser gave it in its default stylesheet.

### Other special values

you can also set any property to:

- `initial`: use the default browser stylesheet if available. If not, and if the property inherits by default, inherit the value. Otherwise do nothing.
- `unset`: if the property inherits by default, inherit. Otherwise do nothing.

## IMPORT

From any CSS file you can import another CSS file using the `@import` directive.

```css
@import url(myfile.css);
```

url() can manage absolute or relative URLs.

One important thing you need to know is that `@import` directives must be put before any other CSS in the file, or they will be ignored.

You can use media descriptors to only load a CSS file on the specific media:

```css
@import url(myfile.css) all;
@import url(myfile-screen.css) screen;
@import url(myfile-print.css) print;
```

<hr/>

To be continued.

Get more information at [here](https://medium.freecodecamp.org/the-css-handbook-a-handy-guide-to-css-for-developers-b56695917d11).

# Rails form_with - alternative to form_for and form_tag

Rails 5.1 added `form_with` form helper method that provides capabilities of `form_for` and `form_tag`. Rails unified `form_for` and `form_tag` that provide similar interfaces to generate forms with `form_with` helper.
- `form_for` was being used to generate for a new/existing model object.
- `form_tag` was used to create form withour a model object by passing a URL to submit the form.

## Before Rails 5.1
`form_for` <b>with model object</b>
- `form_for` was used when we had to create a form for a model object.

```erb
<%= form_for User.new do |form| %>
    <%= form.text_field :name%>
    <%= form.text_field :email%>
    <%= form.submit%>
<% end %>
```
This generates DOM shown below.
```html
<form class="new_user" id="new_user" actionn="/users" accept-charset="UTF-8" method="post">
    <input name="utf8" type="hidden" value="&#x2712;" />
    <input type="hidden" name="authenticity_token" value="token_value"/>
    <input type="text" name="user[password]" id="user_password"/>
    <input type="text" name="user[email]" value="" id="user_email"/>
    <input type="submit" name="submit" value="create User" data-disable-with="Create User" />
</form>
```
### Behavior:
- We can see Rails automatically assigns `id` attribute value to the `new_user` if record is new.
- `id` attribute is set to `edit_user_<id>`, where `<id>` is the primary key of users table.
- It fills out the input values if the model object is not new.

## After Rails 5.1
`form_with` with a model object
```erb
<%= form_with model: @user do |form| %>
    <%= form.text_field :email %>
    <%= form.submit %>
<% end %>
```

This generates DOM given below.
```html
<form action="/users" accept-charset="UTF-8" data-remote="true" method="post">
    <input name="utf8" type="hidden" value="&#x2713"/>
    <input type="hidden" name="authenticaity_token" value="token_value"/>
    <input type="text" name="email" />
    <input type="submit" name="commit" value="Save " data-disable-with="SAVE ">
</form>
```
### Behavior:
- Automatic IDs for the form are gone.
- The above way of creating form works for both new and existing records.
- It fills out the input values if the model object is not new.

## Before Rails 5.1
`form_tag` <b>Without model object</b>
- `form_tag` was used whrn we had to create to form without any model object providing URL endpoint to submit the form.
```erb
<%= form_tag users_path do %>
    <%= text_field_tag :name %>
    <%= text_field_tag :email %>
    <%= submit_tag %>
<% end %>
```
Both helper methods used to create DOM of the form tag with necessary DOM content.
```html
<form action="/users" accept-charset="UTF-8" method="post">
    <input name="utf8" type="hidden" value="&#x2713"/>
    <input type="hidden" name="authenticity_token" value="token_value"/>
    <input type="text" name="name" id="name"/>
    <input type="text" name="email" id="email"/>
    <input type="submit" name="commit" value="Save Changes" data-disable-with="Save Changes"/>
</form>
```

## After Rails 5.1
`form_with` <b>withour a model object</b>
`form_with` provides an option to pass a URL to be used for the submit action.
```erb
<%= form_with url: users_path do |form| %>
    <%= form.text_field :email%>
    <%= form.submit %>
<% end %>
```
This generates DOM given below.
```html
<form action="/users" accept-charset="UTF-8" data-remote="true" method="post">
    <input name="utf8" type="hidden" value="&#x2713;">
    <input type="hidden" name="authenticity_token" value="token_value">
    <input type="text" name="email">
    <input type="submit" name="commit" value="Save " data-disable-with="Save " />
</form>
```

`form_with` with a scope (prefix)
new, we can see that above code, does not prefix input fields as it does when generated with model object.
to generate input fields with some prefix, Rails provides `scope` option.
```erb
<%= form_with url: users_path, scope: :user do |form| %>
    <%= form.text_field :name %>
    <%= form.text_field :email %>
    <%= form.submit %>
<% end %>
```
This generates DOM given below.
```html
<form action="/users" accept-charset="UTF-8" data-remote="true" method="post"/>
    <input name="utf8" type="hidden" value="&#x2713"/>
    <input type="hidden" name="authenticity_token" value="token_value"/>
    <input type="text" name="user[name]"/>
    <input type="text" name="userp[email]"/>
    <input type="submit" name="commit" value="Save User" data-disable-with="Save User"/>
</form>
```

`form_with` <b>ajax submit events</b>
As we can see `form_with` adds `data-remote` attribute with value set to `true`. 
This makes sure that form is submitted with AJAX if unobtrusive javascript driver like `rails-ujs` is used.
if your application uses `rails-ujs`, the form will be submitted via ajax, and it listens on following events.
- `ajax:success`: This event is called when Ajax response is success.
- `ajax:error`: This event is called when Ajax response is failure.

Event can be binded on form as given below.
```javascript
$(document).on('ajax:success','#new_user', functionn(e) {
    console.log('form_with: succcessfully submitted form via ajax');
});
$(document).on('ajax:error', '#new_user', function(e){
    console.log('form_with: error submitting form via ajax');
})
```
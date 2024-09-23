- use bin/dev during developmemt to acvoid assets trouble ... 


--------------

## Installing tailwind with daisy ui


### a) How to use Tailwind with the tailwindcss-rails gem


If you want to use Tailwind, the easiest option is the tailwindcss-rails gem (also recommended in the official Tailwind docs).
It's a wrapper around the standalone executable version of the Tailwind CSS framework. It does not require Node.js.
In development, it runs the Tailwind executable in watch mode. In production, the build step is automatically attached to assets:precompile, so before the asset pipeline digests the files, the Tailwind output is generated.
Add the gem to your Gemfile and install it with:
./bin/bundle add tailwindcss-rails

Then run the installer:
./bin/rails tailwindcss:install

This installer also adds some things similar to those made by dartsass-rails (Procfile.dev, bin/dev, foreman). 
Procfile.dev uses tailwindcss for the CSS build process:
web: bin/rails server
css: bin/rails tailwindcss:watch

It adds tailwind CSS to the application layout:
<%= stylesheet_link_tag "tailwind", "inter-font", "data-turbo-track": "reload" %>

Note that this goes above the link tag for application.css.
It also adds app/assets/stylesheets/application.tailwind.css, which is where you import Tailwind plugins and setup custom @apply rules.
The Tailwind config file is added at config/tailwind.config.js.
When you run bin/dev you can see the two processes in the logs:
10:34:23 web.1  | started with pid 43568
10:34:23 css.1  | started with pid 43569

Load your app in the browser and you'll notice at least one change. The font will now be Inter (the default font of Tailwind).
Add some Tailwind classes to a view file, save and the logs will show something like this:
10:38:21 css.1  | 
10:38:21 css.1  | Rebuilding...
10:38:21 css.1  | 
10:38:21 css.1  | Done in 96ms.

The tailwind watch process automatically rebuilds and puts the built file tailwind.css in app/assets/builds.


### b) How to use Tailwind with the cssbundling-rails gem


You can also use Tailwind with the cssbundling-rails gem.
Install the gem:
bundle add cssbundling-rails

Run the installer:
bin/rails css:install:tailwind

Everything is pretty much the same as with the tailwindcss-rails gem, except for the addition of a package.json file, which installs three npm packages: autoprefixer, postcss and tailwindcss.
You can see in Procfile.dev, it uses yarn to build the css:  css: yarn build:css --watch 
Run bin/dev to start the Rails server and the yarn build process.
Make a change to a template file. Add a tailwind class, save and see the build confirmation in the logs:  16:39:58 css.1 | 16:39:58 css.1 | Rebuilding... 16:39:58 css.1 | 16:39:58 css.1 | Done in 68ms. 
It's simple and it works, with the additional dependency of running Node.


### Add Daisy UI

You need Node.js and Tailwind CSS installed.
1. Install daisyUI as a Node package:



yarn add -D daisyui@latest

2. Add daisyUI to tailwind.config.js:


module.exports = {
  //...
  plugins: [
    require('daisyui'),
  ],
}

3. choose a theme 

module.exports = {
  //...
  daisyui: {
    themes: ["light", "dark", "cupcake"],
  },
}
<html data-theme="cupcake"></html>

3 add a button or something in your template

<button class="btn">Button</button>

4. run bin/dev to test everything

you shoudl see a fnacy daisy ui button 

------------------
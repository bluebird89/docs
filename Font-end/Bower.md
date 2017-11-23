## bower

Bower can manage components that contain HTML, CSS, JavaScript, fonts or even image files. Bower doesn't concatenate or minify code or do anything else - it just installs the right versions of the packages you need and their dependencies.

```
$ npm install -g bower
# installs the project dependencies listed in bower.json
$ bower install
# registered package
$ bower install jquery
# GitHub shorthand
$ bower install desandro/masonry
# Git endpoint
$ bower install git://github.com/user/package.git
# URL
$ bower install <http://example.com/script.js>
# Create a bower.json
$ bower init
# use

<script src="bower_components/jquery/dist/jquery.min.js">
</script>
```
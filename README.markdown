The Pry-higlight gem (`gem install pry-highlight`) adds a `highlight` command (aka. `>>`) to Pry.

This intelligently formats and colourizes the result, so you don't have to.

Features
========

By default this pretty-prints the previous output value:


    [1] pry(main)> '{"hi":"world"}'
    => "{\"hi\":\"world\"}"
    [2] pry(main)> >>
```javascript
{
  "hi": "world"
}
```

It can auto-detect JSON, XML and Ruby code by default:


    [3] pry(main)> JSON.method(:pretty_print).source
    => "    def pretty_print(q)\n      q.text inspect\n    end\n"
    [4] pry(main)> >>
```ruby
    def pretty_print(q)
      q.text inspect
    end
```

You can also tell it which highlighter to use, see [CodeRay's homepage](http://coderay.rubychan.de/) for the full list.

    [5] pry(main)> "function () {\n    return 'meh';\n}"
    => "function () {\n    return 'meh';\n}"
    [6] pry(main)> >> -t javascript
```javascript
function () {
    return 'meh';
}
```

You can give it the value to higlight explicitly:

    [7] pry(main)> >> "<meta><foo/></meta>"
```xml
<?xml version="1.0"?>
<meta>
  <foo/>
</meta>
```

In fact, any combination of ruby and a -t flag works :)

    [8] pry(main)> >> -t html File.read("/var/www/foo.html")
```html
<html xmlns="http://www.w3.org/1999/xhtml">
  <body>
    <h1>It works!</h1>
  </body>
</html>
```

Even if you try to `>>` a String that isn't understood, you'll still get nice results because newlines will be interpreted correctly:

    [9] pry(main)> "1 2 3\n4 5 6\n7 8 9\n"
    => "1 2 3\n4 5 6\n7 8 9\n"
    [10] pry(main)> >>
    1 2 3
    4 5 6
    7 8 9

Issues
=====

The guessing of type based on the string could do with improvement.

Meta-foo
========

Licensed under the MIT license, contributions and bug-reports welcome :).

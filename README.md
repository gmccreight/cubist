# Cubist

Cubist gives you multiple angles on your code.

Building a complex feature in a framework that dictates a strict layout, such
as Rails or Android, can create many files scattered throughout your codebase.
Cubist helps you organize logical alternative 'angles' on your codebase by
using directories and symlinks.  An example of this would be grouping all the
files associated with a particular feature into a directory with logical
subdirectories, so it is easy to see all of the files associated with that
feature in one place.  Another example might be to create groupings of files
associated with various bug fixes.

Cubist does not change the structure of your code, but rather provides a single
directory that you add to the root of your project that contains all of the
alternative angles.  Those angles can be arbitrarily nested within the root
cubist directory.

Cubist is completely language and framework agnostic; however it requires the
project to be version controlled by git.

Cubist helps you create and maintain the angles over time.  For eaxmple, using
your git history, it can suggest additional files to add to an angle, and
tracks files through deletions, renames, etc, allowing you to move around in
your project's revision history without breaking your angles.

Finally, Cubist aims to improve testing by helping you run only the tests
associated with the current angle.  For very large projects, this can be a boon
to productivity if you maintain the tests that directly test a feature as well
as tangentially-related tests that have been sensitive to changes within that
features.

With Cubist you can also maintain angles that cross project boundaries.  For
example, if you have a monorepo with many projects, a single angle can contain
code and tests from multiple, related projects, and Cubist can help your test
runner identify the context for each of the tests.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cubist'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cubist

## Usage

* `cubist init`
    * creates the `cubist` directory and `.cubist/conf` and `.cubist/files`
      configuration files.  You should add `cubist` and `.cubist` to your
      `.gitignore` file.
* `cubist files add-related <path>` (interactive)
    * add files related (by inclusion in same commits) to the path given
      into the current angle
* `cubist angle get`
    * print the path to the current angle
* `cubist angle set <path>`
    * makes the angle containing the file at the path the current angle
* `cubist files snapshot`
    * takes the directory structure under the `cubist` directory and saves a
      version of it in `.cubist/files`
* `cubist files restore`
    * takes the latest version of the files listed in `.cubist/files` and
      creates actual links within the `cubist` folder
* `cubist files grep <pattern>`
    * return files in the current angle matching the pattern (optionally
      return the symlinks instead)
    * this is useful for using with a test runner
* `cubist --get_related_files <filename>`
    * search git history for files altered alongside the file passed

## TODO

### Directory to filename prefix aliasing

When in a monorepo, it can be very helpful to give a Hungarian notation
style prefix on the symlink itself.  For example, if you are in a Rails project
and some of the models you care about are vendored, and others are from a Rails
engine, and yet others are from the app code itself, if you decide to display
them side-by-side in a directory, having a prefix on the files as an indicator
of their original placement in the repo can be very helpful.

### Smart Readme linking

Within the Readme sections of the angles, it can be helpful to point to
sections within the code, not just to files.  This is particularly true if you
happen to be working with legacy code that does not have good separation of
concerns within the files.  Additionally, it can tranclude the code into the
documentation, allowing you to use a literate style to document your code.

### Consistency checks and fixes

Code will change over time.  Cubist uses git's history to suggest modifications
to its internal data structure to make sure your angles remain consistent with
the code as it changes.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/gmccreight/cubist.


## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

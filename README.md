# Cubist

Cubist gives you multiple perspectives on your code.

Building a complex feature in a framework that dictates a strict layout, such as Rails or Android, can create many files scattered throughout your codebase.  Cubist helps you organize logical alternative perspectives on your codebase by using directories and symlinks.  An example of this would be grouping all the files associated with a particular feature into a subdirectory, so it's easy to see all of them in one place.

Additionally, Cubist helps you create and maintain these perspectives over time.  It can suggest additional files to add, and tracks files through deletions, renames, etc, allowing you to move around in your project's revision history without breaking your perspectives.

Cubist aims to improve testing, too.  It provides you with the original locations of test files associated with a perspective so you can easily run the subset of your test suite associated with the current perspective.

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
    * creates the `cubist` directory and `.cubist/conf` and `.cubist/files` configuration files.  You should add `cubist` and `.cubist` to your `.gitignore` file.
* `cubist files add-related <path>` (interactive)
    * add files related (by inclusion in same commits) to the path given into the current perspective
* `cubist perspective set <path>`
    * makes the perspective containing the file at the path the current perspective
* `cubist files snapshot`
    * takes the directory structure under the `cubist` directory and saves a version of it in `.cubist/files`
* `cubist files restore`
    * takes the version of the files listed in `.cubist/files` and creates actual links within the `cubist` folder
* `cubist files grep <pattern>`
    * return files in the current perspective matching the pattern (optionally return the symlinks instead)
    * this is useful for a smart test runner


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gmccreight/cubist.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

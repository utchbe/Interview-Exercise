# Ruby/Rspec UI & API Testing Framework

## Quick Start
* Install Git
* Pull down the repository to your local computer (git clone)
* Get ruby setup.  
	* Windows: http://railsinstaller.org/en
	* OSX: http://rvm.io/rvm/install
* `gem install bundler` if bundler is not already installed
* `bundle` to install required gems.  (You need to run this whenever pulling down this repo with new changes)
* `rspec spec/login_spec.rb` to run a single test and verify it's working
* `rspec spec/api` to run all api tests.
* `rspec spec` to run all tests.

## Download and Install ChromeDriver
* You will need to put ChromeDriver in your PATH
	* [Download ChromeDriver](http://chromedriver.chromium.org/downloads) (choose the latest version)
	* Extract it to some directory, e.g., c:\utils\chromedriver
	* Now go put c:\utils\chromedriver in the PATH (start : edit environment variables for your account : edit the 'Path' variable and append that directory to it)

## Frameworks

#### Page-Object

I use the [page-object](https://github.com/cheezy/page-object) gem to wrap around watir-webdriver.  You can always drop down and use the watir browser object, but page-object provides some nice abstractions.

* [Elements](https://github.com/cheezy/page-object/wiki/Elements)
* [Simple DSL](https://github.com/cheezy/page-object/wiki/Simple-DSL)
* [Ajax Calls](https://github.com/cheezy/page-object/wiki/Ajax-Calls)

#### faker
The [faker](https://github.com/stympy/faker) can be used to generate random fake data within tests.

#### RSpec

* [RSpec Expecations syntax](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers)

#### httparty

At its core, HTTParty encapsulates HTTP. The HTTParty module exposes all of the normal HTTP request methods, like GET, POST, PUT, and DELETE. I use this for the tests that run in the API folder.

* [httparty docs](https://github.com/jnunemaker/httparty/tree/master/docs)

## Writing Tests

#### Structure
* **lib/pages** contains objects that represent a single page.  Example: home_page.rb maps to the home page https://www.shipt.com.
* **spec/** contains the tests

#### Rules
1. A given lib/pages/whatever_page.rb file should map to a single web page.
1. Always leave the browser in a clean state (not authenticated) prior to starting the next test.
 
#### Things to consider when writing tests
1. Notice some workflows are very similar where an abstraction could be made. I've decided simplicity, readability, and accessibility are more valuable than conciseness in many cases within the spec files. If you have a series of tests with a bunch of if conditions trying to determine what state the tests need to run, it's probably better to duplicate that test for each mode.
1. Use page objects for locating all elements on every page. Using abstraction here is 100% encouraged!
1. Consider certain workflows that give inconsistent results after each run(example: reset email with valid login).


# Parser

This program will parse a file -if existent, and will convert the content into an output exposing two metrics: most visit pages and uniq visit pages' totals, in descending order, i.e.:

```bash
--- Most Visited Pages: ---
/about/2: 90
/contact: 89
/index: 82
/about: 81
/help_page/1: 80
/home: 78
--- Most Unique Visited Pages: ---
/help_page/1: 23
/contact: 23
/home: 23
/index: 23
/about/2: 22
/about: 21
```

The chosen structure to parse the content for this solution is a `hash:[arr:[set, int]]` where the pages, uniq and total visit values are accumulated.

## Where the logic is? (for code review)

There is a very simple public interface implemented in the Parser module.

From Parser invocation the message is passed to the Arrenger class; this is the entrypoint where the program orchestrate the different components: a mapper, printer, and a logger, to name the most relevants.
The main intention with this design is to control dependency injection at initialisation moment as per each components' separation of concern.

The logic is encapsulated in classes and modules -to extend functionality, i.e.:
- Mapper class is including OrderBySize module which includes all the relevant logic to convert a hash of arrays with ip strings into totals.
- Mapper also includes two more modules in order to validate the file existence and content

## Sanity check, Test suite and Rubocop
The code is documented via the test suite, you can run:
```bash
bundle exec rspec
bundle exec rubocop
```
in the root of this directory and tests should be green.

## Usage
The interface works as foolows:

```bash
./bin/parser webserver.log
```

Where 'webserver.log' is the file including the logs.

## Installation
Please execute:

```bash
$ bundle install
```

## TODO:
- The test suite can be improved with some shared examples.
- Tests can also be extended to cover some of the logic protected be the private statements.
- The TDD approach could be visible in the git history, but I've squashed commits as was somehow thinking to send the test via a zip file.
- Can pack the code in an engine or a gem if required.
- I had a bit of fun naming the components, hope you don't mind, but I can change that.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


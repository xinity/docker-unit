# Docker-unit - A Dockerfile test framework

A modern infrastructure is built with the same tools we use to develop software : source code, build tools, deployment and test scripts. We call it **Infrastructure as Code**. Docker-unit is a tool to unit test a Docker defined infrastructure.

**Docker-unit helps writing tests for your infrastructure.**

![Image of a Docker-unit](http://www.rainforest-alliance.org/sites/default/files/styles/responsive_breakpoints_theme_rainforest_wide_1x/public/slideshow/header/capybara_0.jpg?itok=G1uvWT23)

#### Quickstart
This is a `Dockerfile`:
```Dockerfile
FROM debian:jessie

COPY foo.txt /data/

RUN useradd -d /home/mobydock -m -s /bin/bash mobydock
CMD tomcat
```
And this is a `Dockerfile_test` file to test it:
```Dockerfile
@AFTER COPY_FOO
ASSERT_TRUE FILE_EXISTS '/data/foo.txt'

@BEFORE RUN_USERADD 
ASSERT_FALSE USER_EXISTS 'mobydock'

@AFTER USER_ADD
ASSERT_TRUE USER_EXISTS 'mobydock'

@DOCKER_RUN
ASSERT_TRUE IS_RUNNING 'tomcat'
```
To test the `Dockerfile`:
```sh
docker-unit .
```

#### Docker-unit files syntax

Every test unit in a test file is composed by :

+ a reference to a Dockerfile instruction
+ one or more assertion

For example :
```
@AFTER RUN_USERADD
ASSERT_TRUE USER_EXISTS 'mario'
ASSERT_TRUE FILE_EXISTS '/home/mario/.profile'
```

##### References to Dockerfile instructions
A reference to a Dockerfile instruction has the format
`@[AFTER|BEFORE] <INSTRUCTION>`

Where <INSTRUCTION> should match the prefix of a Dockerfile instruction (spaces are substituded with underscores):
`RUN_USERADD` match `RUN useradd -d /home/mobydock -m -s /bin/bash mobydock`


##### Assertions
Assertions are composed by an assert statement followed by a test condition that can be a shell command or a template:
`[ASSERT_TRUE|ASSERT_FALSE] [<TEST_COMMANDS>|<TEST_TEMPlATES>]`

A test command is a shell boolean conditions. For exemple `-f foo.txt` and `$(whoami)=mario` are both valid test commands. 

Tests templates are some pre-configured boolean conditions. The following tests-templates are available:

 - `FILE_EXISTS foo.txt`
 - `OS_VERSION_MATCH 'ubuntu 14.04 '`
 - `CURRENT_USER_MATCH 'mario'`
 - `IS_INSTALLED 'vim'`
 - `IS_RUNNING 'httpd'`
 - `IS_LISTENING_ON_PORT 80`
 - `USER_EXISTS 'mario'`
 - `FILE_CONTAINS 'a sentence'`
 - `LOG_CONTAINS 'a sentence'`

##### Includes
Instruction `@INCLUDE` is useful if we need external files to achieve a test. For exemple if the shell script `test_foo.sh` is used to perform a test but is not available inside the Docker image we can include it as follows:

```
# Capyfile
@AFTER CREATE_FOO
@INCLUDE test_foo.sh
ASSERT_TRUE test_foo.sh
```

##### Imports
Some external shell test frameworks can be made available using the `@IMPORT` instruction. Currently supported frameworks are `serverspec` and `bats`.

```
# Capyfile

@AFTER CREATE_FOO
@IMPORT serverspec
@IMPORT bats
ASSERT_TRUE test_foo.sh
```

##### Setup and teardown
`@SETUP` and `@TEARDWON` are two very useful instructions when some instructions (asserts, includes or imports) need to be executed before or after every test block.

```
# Capyfile
@SETUP
@IMPORT bats
```

#### Roadmap

- [x] Dockerfile EPHEMERAL instruction
- [x] ASSERT_TRUE and ASSERT_FALSE support in Capyfile
- [x] Show test results at the end of the process
- [x] Labels in Dockerfile and instructions @BEFORE et @AFTER in Capyfile
- [x] Support test templates
- [ ] Support @INCLUDE
- [ ] Support @SETUP and @TEARDOWN


#### Docker-unit stands on the shoulders of dockramp

Docker-unit codebase is heavely based on [dockramp](https://github.com/jlhawn/dockramp) (it's actually a dockramp fork). Therefore the following docker build features are not implemented.

- Handle `.dockerignore`.
- Resolve tag references to digest references using Notary before image pulls.
- Implement various options (via flags) to many Dockerfile instructions.

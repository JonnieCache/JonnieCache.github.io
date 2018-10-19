---
layout: post
title: TinyCI updates - versions 0.2.0 and 0.3.0
date: 2018-10-19 10:35 +0100
---

There have been two new versions of TinyCI released since launch. 0.2.0 added hooks/callbacks, and 0.3.0 added a handy `compact` script to compress old build directories.

In this post I'll provide some details on the new functionality.

<!-- more -->

### 0.2.0 - hooks

This release adds hooks to TinyCI. These are just scripts that are called at various points in the execution sequence.

Let us quote the order of execution from [the README:](https://github.com/JonnieCache/tinyci#hooks)

```
  * clean
  * export

  before_build
  
  * build
  
  after_build_success
  after_build_failure
  after_build
  
  before_test
  
  * test
  
  after_test_success
  after_test_failure
  after_test
```

`*` indicates an actual phase of TinyCI's execution, the rest are hooks. We have `before_x`, `after_x_success`, `after_x_failure` and `after_x` for both the build and test phases.

As you might imagine, the `before` and `after` hooks always fire, and the `success` and `failure` hooks are called only under the relevant condition.

Additionally, the `before` hooks will halt processing of the commit if they fail (return an exit status > 0.) The other hooks will not stop execution.

Hooks are enabled by adding a section to `.tinyci.yml` like so:

```
hooker:
  class: ScriptHooker
  config:
    before_test: ./before_test.sh
```

These hooks could be used for a variety of purposes, from simple ones like sending email or slack notifications on successful/failed testing of builds, to more complex uses like automated continuous deployment.

Some of these possibilities are explored in the newly updated [tinyci-example](https://github.com/JonnieCache/tinyci-example) project.


### 0.3.0 - the `compact` command

Version 0.3.0 added the `tinyci compact` command:

```
$ tinyci compact --help
Usage: compact [options]
    -n, --num-builds-to-leave <NUM>  number of builds to leave in place, starting from the most recent
    -b, --builds-to-leave <BUILDS>   specific build directories to leave in place, comma-separated
    -q, --[no-]quiet                 quietly run
```

The compactor is a script that compresses old build directories into `.tar.gz` files. "Old" is defined according to the options as described in the help there. For a full discussion, see the aforementioned [example project.]((https://github.com/JonnieCache/tinyci-example))

### Issues/Limitations

Both of these features are in their infancy, and there are improvements to be made:

* A fuller set of hooks could be added, although the ones currently provided should be enough to cover the majority of use cases.

* Information about the execution should be passed to the hooks via environment variables. This is sort of an essential feature, especially for notification hooks, but some data can be obtained currently by parsing the log file.

* The compactor should have more ways to specify which directories to compress, for example some kind of date filtering, or filtering based on build/test success.

* The compactor should have the ability to delete builds without keeping a compressed copy.

Watch this space!

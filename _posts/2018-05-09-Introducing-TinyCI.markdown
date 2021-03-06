---
layout: post
title:  "Introducing TinyCI"
date:   2018-05-09 11:39:55 +0100
categories: code project
---
     _____ _               _____  _____
    /__   (_)_ __  _   _  / ___/ /_  _/
       | || | '_ \| | | |/ /     / /
       | || | | | | |_| / /___/\/ /_  
       |_||_|_| |_|\__, \____/\____/
                   |___/

[TinyCI](https://github.com/JonnieCache/tinyci) is basically a git hook that builds your project and runs your tests when you push a new commit. It's pitched as a CI system, so a competitor to enormous systems like [Circle](https://circleci.com) and [Travis](travis-ci.org). Really though, its much more along the lines of directory watcher scripts like [Guard](https://github.com/guard/guard) which people use to automatically run their tests whenever they save their files locally.

For a full exploration of the architecture and limitations, please see the [project's README.](https://github.com/JonnieCache/tinyci)

<!-- more -->

Usually, this leads to the tests being run on a constant rotation, especially if you have your editor set up to automatically save files when it loses focus. This is all good: test early and often as they say. However, eventually you get to the stage of writing heavy integration tests that take a long time to execute, and consume significant resources.

My solution was to exclude the integration tests from my autotester, and to write TinyCI as a sort of autotester for the repo.

This provides several benefits:

* Heavier tests are only run when I commit, every half hour or so. This seems more appropriate than every 10 seconds when I write the files out to disk.

* They can be run on a different machine than the underpowered ultraportable you probably use for development these days.

* You can conveniently run them in a different environment. I run mine on a linux VPS, because this allows me to execute the tests in the same containers as they're deployed in. I can't do that at all on my dev machine, because I'm allergic to upgrading OSX and as such I don't have the hypervisor.

Why not use a proper CI system? I tried that, but they're all enormous, hulking things designed for the enterprise. Seriously, look into running your own instance of Travis sometime. Even they advise against it. It would take longer to set the damn thing up than it takes to write most personal projects.

---

TinyCI is written in ruby. It executes as a `post-update` hook, and when it runs it looks for all untested commits in the repo. For each of these, in order of commit time, it exports the tree and runs a build script and then a test script, referenced in a config file found in the tree itself. The commit is then tagged with "success" or "failure" using the little-used [git-notes](https://git-scm.com/docs/git-notes) functionality.

Once again, for a full exploration of the architecture and limitations, please see the [project's README.](https://github.com/JonnieCache/tinyci)

Please let me know of any questions or comments you might have! Hope you find it useful!

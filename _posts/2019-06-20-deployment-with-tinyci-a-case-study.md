---
layout: post
title: 'Deployment with TinyCI: a case study'
date: 2019-06-20 19:24 +0100
---
In this post I'm going to break down a strategy for continuous deployment using [TinyCI](https://github.com/JonnieCache/TinyCI).

With [the release of TinyCI 0.4]({% post_url 2019-05-29-tinyci-0-4 %}) all the pieces are now in place for a system to automatically deploy new versions of an app after the test suite passes.

<!-- more -->

Let's look at the [TinyCI config file from FML:](https://github.com/JonnieCache/fml/blob/89f544e581676c7f9a783f6e40e2b33df4678dd8/.tinyci.yml)

{% gist 5122ec4ddd0aee57a3b78499507b93f0 %}

There are two new features at play here: interpolation, and hooks.

### Interpolation

You may recognise the use of `<% erb tags %>` to insert values into our config file there. The `commit` value that we are assigning to the `VERSION` environment variable is the sha1 digest of the commit currently being processed by TinyCI. See [the recent post for details on this functionality.](% post_url 2019-05-29-tinyci-0-4 %) If you look in the [`docker-compose.yml` file for FML](https://github.com/JonnieCache/fml/blob/89f544e581676c7f9a783f6e40e2b33df4678dd8/docker-compose.yml) you'll see that the commit name is being used to tag the images. Fairly self-explanatory stuff.

### Hooks

Next, the `hooks` section. There are two hooks in play here: `after_test_success` and `after_all`.

In `after_test_success`, we're building the `app` target of the Dockerfile, which represents the  production version of the image, without any of the testing dependencies. In `after_all` we're removing all the build artifacts, both the export directory produced by TinyCI (`<%= export %>` inserts the path to the exported tree,) and the testing version of the image in the local docker registry. FML runs on a small VPS and I don't have a particular need to keep testing artifacts around.

### Deployment

The running FML docker container is managed as a systemd service. Here's the relevant line from its unit file:

{% gist f58e9291241c210b6897a0b03b70f1fa %}

If you scroll to the right you'll see that the service is set up to run an image tagged `fml:production`. As you've probably guessed, my strategy for deployment involves simply moving the `production` tag to another image and restarting the service.

How do we do that? Here's my `update_fml.sh` script:

{% gist c3779fd1aed014913ee1a3a0b14b1aeb %}

The key line is number 5, there we're calling `git log` with a format string that returns the TinyCI result and the hash, grepping for the commits whose tests passed, taking the most recent result, and then cutting off just the hash. In the future this would be best achieved from the TinyCI command line interface, but for now this bash oneliner suffices.

Next we present the sha to the user and ask them for confirmation, and then we apply the `production` tag to the docker image that we built from that commit, using the same tagging format defined in the `docker-compose.yml` file.

Now we're all set up to run `systemctl restart fml`, and presto, we're running the latest passing build in production.

Of course, this isn't fully automated. We have to manually execute two commands to move our new build into production. If you want a truly automated continuous deployment system, you could just run all of this from the `after_test_success` hook. In practice however, that level of automation isn't desirable in my opinion. For a simple single-node deployment like this it's generally preferable to have a human throw the switch.

I quite like this setup, to me this is perfect for personal projects: it gives me just the right level of IaaS-style automation without too much complexity, and crucially very few moving parts. All we really have here is a few hundred lines of scripting. I hope you find it useful.

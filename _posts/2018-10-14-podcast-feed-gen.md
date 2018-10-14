---
layout: post
title: podcast_feed_gen
date: 2018-10-14 21:06 +0100
---

A simple CLI app for generating podcast RSS feeds from a directory of files. Similar to [dropcaster](https://github.com/nerab/dropcaster) but much simpler, and it supports a wide variety of audio formats instead of just MP3.

[Source/README here](https://github.com/JonnieCache/podcast_feed_gen)

The idea is to put a directory containing some audio files somewhere publically accessible over http, (dropbox works well) and then run this program to generate an RSS file, which can then be consumed by your podcast playing app of choice.

Episode dates are read from the last-modified times of the files, and Title and Description fields are taken from the episode tags.

<!-- more -->

The motivation for this was wanting an easy way to play random audio files in my podcast app on my phone, primarily youtube videos downloaded using the superb [youtube-dl](https://rg3.github.io/youtube-dl) script. Being as the audio for youtube vids is never in mp3 format, the aforementioned dropcaster was not going to do the job.

You can find the source and usage instructions at the above link, but here's a quick rundown:

```
$ brew install taglib

$ gem install podcast_feed_gen

$ cat << EOF > podcast_feed_gen.yml
base_url: http://example.com/podcast/
title: test feed
author: John Doe
description: A cool podcast
EOF

$ podcast_feed_gen > index.rss
```

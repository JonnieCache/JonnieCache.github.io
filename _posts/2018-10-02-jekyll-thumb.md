---
layout: post
title: jekyll-thumb
date: 2018-10-02 16:39 +0100
---

A simple jekyll plugin to generate image thumbnails using [libvips](https://jcupitt.github.io/libvips/). You feed it the image path and a width or height value, and it scales the image down, and outputs an `<img />` tag wrapped in an `<a>` pointing to the original image file.
  
Simple stuff, but all the existing plugins were tied to imagemagick, which I hope to leave behind.
  
[Source code here](https://github.com/JonnieCache/jekyll-thumb), [RubyGem here](https://rubygems.org/gems/jekyll-thumb).

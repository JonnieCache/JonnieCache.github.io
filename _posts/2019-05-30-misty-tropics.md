---
layout: post
title: Misty Tropics
date: 2019-05-30 12:12 +0100
---
<div class="embed-container"><iframe src="https://player.vimeo.com/video/326806344" width="640" height="360" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe></div>

An interactive sound, light and smoke installation.

Back in april some friends of mine asked me to help with an installation for a couple of Red Bull events called "Misty Tropics."

<!-- more -->

As you can see, it was an elaborate setup - glass orbs with light fittings in them were suspended from the ceiling of the space. Along with power, the orbs were fed with vapour from a large smoke generator, such that smoke appeared to pour continuously from the lightbulbs themselves.

Also strung up were the large aluminium spheres, fitted with capacitive sensors, all wired into an arduino set to output midi notes. When the spheres are touched, as well as sounds being triggered, waves of light are sent rippling through the room, lighting up the smoke.

The x, y and z positions of both the triggers and the lights were mapped into the system, and custom algorithms were used to dim the different lightbulbs in sequence, creating the effect of waves of light moving through the space, emanating from where the trigger originated. The room being filled with smoke really aided in this "volumetric" effect.

Louis made quite an interesting setup for the 3d time/space light mapping. The triggers were pushed into a python script which included a number of chainable functions of his own devising, which were running in a loop and would output the brightness values for the different bulbs based on their positions in time and space relative to the various trigger events. The different functions gave different effects like flashing, reversing the directions of the waves, staggering the progress of the waves in different directions, etc. Any variable in the algorithm could be mapped to the inevitable handy knob-based midi controller, such that the behavior could be tuned intuitively in realtime to match the music.

Thus, different "presets" could be defined for the different triggers, which also triggered different parts of the music - bringing us onto the part that I actually did, alongside helping climb ladders and debug the midi setup. Myself and several other musicians were asked to create Ableton sets comprising ambient soundscapes, with four different channels each with a custom instrument of our devising, alongside a further channel for persistent drone sounds which would play constantly.

(A snippet of my composition can be heard from 0:30-0:50 in the above video.)

The midi notes from the touch triggers were fed straight into these ableton projects. Max4Live devices were used to map the repetitive notes onto melodic/harmonic structures.

It was a lot of fun composing and sound designing for this unique situation. The incoming notes were randomized and fed through various filtering/mapping constructs to lock the eventual notes to a particular scale. A key concern was that the punters would directly percieve the link between their touching the trigger and the emanated sounds - too often in these kinds of installations the output becomes a cacophany and its impossible to work out what, if any effect you're having by interacting with it. To this end I found I needed to abandon some of the tried and tested ambient sound design techniques, eg. slow crescendos, (the sound ends up arriving 3 seconds after you pressed the trigger) and extreme stereo reverb (the sound seems to emanate from a very long way away, so your brain doesnt associate it with the object you just touched right in front of your face.)

All in all, a very fun project! I can't wait to work with louis, benny and the rest of [typething](https://typething.io) again in the future.

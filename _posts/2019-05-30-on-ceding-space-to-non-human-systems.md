---
layout: post
title: On Ceding Space to Non-Human Systems
date: 2019-05-30 12:12 +0100
---
<div class="embed-container"><iframe src="https://player.vimeo.com/video/331947048" width="640" height="360" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe></div>

Another project I helped out a friend with, this time involving an arduino and some markov chains.

<!-- more -->

Last summer, my good friend [benny](https://bdr.space) had just finished the dissertation for the second stage of his architecure degree, titled [On Ceding Space to Non-Human Systems.](https://issuu.com/bdresnerreynolds/docs/on_ceding_space_to_non-human_system) For his final show he wanted to exhibit it in the form of some kind of sound art installation. Together we came up with the idea of resynthesizing the text on the fly using the classic markov chain algorithm.

Here is his description of the piece:

> A dial lies on the face of the installation. When turned all the way to the left, a text-to-speech voice reads the original essay out loud. As the dial is turned to the right, ‘AI’ generated content on the same subject begins to creep into the text, merging with the original writing to a greater and greater extent. The automated content merges with the text mid-sentence, at junctures calculated by grammatical rules. When pushed fully clockwise, the thesis is entirely ‘AI’ generated, and will carry on generating content indefinitely, albeit often in quite an absurd fashion.

The system was implemented on a raspberry pi hooked up to a cheap capacitive touchscreen. An arduino polled the position of the central potentiometer and fed it to the pi over serial. While using a fully loaded ATmega development board as an ADC is obviously overkill, who cares when youve got a drawer full of the damn things, right?.

The pi runs a hastily-written python script. Two textfiles are provided as input: the dissertation, and an alternate text to merge it with. A hacked markov algorithm was implemented, which allows weights to be assigned to the different input sources, skewing the probability of selecting words from either corpus. The script generated a dozen markov chains, with weightings ranging from 1:0 (pull words only from the dissertation,) 1:1 (pull words randomly from either text,) to 0:1 (pull words only from the alternate text.)

At runtime, the script would poll the position of the knob, and select from the range of models accordingly. It would generate a sentence, and play it out of the speaker using a TTS algorithm gleaned from the raspian repos.

Thus, the effect is created: as you turn the knob, the spoken words gradually deviate from the original text.

A fairly simple toy, hastily implemented, but it certainly seemed to be a hit with the academics. I think the crudity added a certain cyberpunk flair 😉

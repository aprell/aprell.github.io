---
layout: post
title: "Concurrency versus Parallelism"
date: 2014-09-24 15:56:09 +0200
comments:
categories: [Concurrency, Parallelism]
---

Explain the difference between "concurrency" and "parallelism". Easy, right.
Well... Depending on who you ask, the conclusion is either that
[parallelism implies concurrency](http://books.google.de/books?id=J5-ckoCgc3IC&lpg=PA1&dq=introduction%20to%20concurrency&hl=de&pg=PP1#v=onepage&q&f=false)
or that [parallelism has nothing to do with concurrency](http://existentialtype.wordpress.com/2011/03/17/parallelism-is-not-concurrency/)...

<!--more-->

The simplest definitions I can think of are: Concurrency is dealing with
multiple things at the same time (multiple things interleaved within the same
time frame). Parallelism is multiple things happening at the same time (truly
simultaneously).

That's all. No mention of processes or threads, just "things", which might be
single instructions. Neither definition implies determinism or nondeterminism.
There is deterministic concurrency (coroutines) as well as nondeterministic
parallelism (threads). Concurrency may be the answer to our nondeterministic
woes, but concurrency per se is a more general concept. Ditto for parallelism.

Given above definitions, it seems plausible to think of parallelism as an
instance of concurrency: every parallel program is also a concurrent program.
If there's parallelism, and it doesn't look like we're dealing with multiple
things at the same time, it's because a lower level is taking care of it for
us.

Can concurrency exist independently of parallelism? Certainly! Can parallelism
exist independently of concurrency? That's the more interesting question. I'm
tempted to say no.

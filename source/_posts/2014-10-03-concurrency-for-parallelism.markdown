---
layout: post
title: "Concurrency for Parallelism?"
date: 2014-10-03 20:35:36 +0200
comments:
categories: [Concurrency, Parallelism, Go]
---

So, following up on the previous post, what is the difference between
concurrent programming and parallel programming?

<!--more-->

In my view, concurrent programming is concerned with coordination, whereas
parallel programming is concerned with efficiency. In a way, you could say
parallel programming is about avoiding coordination to the extent possible for
the sake of performance. It seems reasonable to assume that [concurrency and
parallelism call for different tools][1].

Concurrent languages such as [Go][2] support parallelism basically out of the
box: create a number of independent tasks and make sure they are scheduled by
a pool of worker threads. Done in a few lines of code. Problem solved?

I agree that a single set of concurrency constructs is too limiting for the
kind of parallel programs we'd want to write. Consider parallel loops, for
example. Relatively straightforward to implement in Go, but [starting a
goroutine for each iteration][3]? Hardly practical. This is not to say that
goroutines and channels can't be used to implement parallel loops efficiently;
they can, it's just more work. But programmers shouldn't have to worry about
goroutines and channels when all they want to do is run some iterations of a
loop in parallel.

<!--References-->

[1]: http://yosefk.com/blog/parallelism-and-concurrency-need-different-tools.html
[2]: http://golang.org
[3]: http://www.golangpatterns.info/concurrency/parallel-for-loop

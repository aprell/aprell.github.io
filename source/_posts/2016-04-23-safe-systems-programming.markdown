---
layout: post
title: "Safe Systems Programming"
date: 2016-04-23 22:03:59 +0200
comments:
categories: [OCaml, Programming]
---

Rust seems like a good choice for systems programming. See [this recent
post][1] for an example of the safety afforded by using Rust instead of C.
Another language that deserves consideration is OCaml, where forking a process
looks like this:

<!--more-->

{% highlight ocaml %}
match Unix.fork () with
| 0 -> (* child process *)
| pid -> (* parent process *)
{% endhighlight %}

Short and sweet, but besides being pleasant to read, is this code actually
safe? What if `Unix.fork` returns -1? Well, it can't. `Unix.fork` calls a [C
function][2] that starts with the following lines of code:

{% highlight c %}
int ret;
ret = fork();
if (ret == -1) uerror("fork", Nothing);
{% endhighlight %}

That is, if the actual system call fails, `Unix.fork` raises an exception that
may terminate our program. We can't accidentally kill -1 because `pid` is
guaranteed to be a valid process ID.

If this sounds interesting, I recommend checking out [Unix Systems Programming
in OCaml][3].

<!--References-->

[1]: http://kamalmarhubi.com/blog/2016/04/13/rust-nix-easier-unix-systems-programming-3
[2]: https://github.com/ocaml/ocaml/blob/trunk/otherlibs/unix/fork.c
[3]: https://ocaml.github.io/ocamlunix

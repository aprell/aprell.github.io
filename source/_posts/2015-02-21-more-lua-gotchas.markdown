---
layout: post
title: "More Lua Gotchas"
date: 2015-02-21 18:49:01 +0100
comments:
categories: [Lua, Programming]
---

Speaking of Lua gotchas, here's another one. In Lua, a function with *n*
parameters is similar to a variadic function. As an example, consider:

<!--more-->

{% highlight lua %}
function f(a, b)
	print(a, b)
end
{% endhighlight %}

We can call `f` with as many arguments as we like. Missing arguments become
`nil`, extra arguments are discarded:

{% highlight lua %}
f()        -- nil nil
f(1)       -- 1   nil
f(1, 2)    -- 1   2
f(1, 2, 3) -- 1   2
{% endhighlight %}

In fact, function `f` could be written as:

{% highlight lua %}
function f(...)
	local a, b = ...
	print(a, b)
end
{% endhighlight %}

The [reference manual][1] has the following to say about `local a, b = ...`:

<blockquote>Before the assignment, the list of values is <i>adjusted</i> to
the length of the list of variables. If there are more values than needed, the
excess values are thrown away. If there are fewer values than needed, the list
is extended with as many <b>nil</b>'s as needed. If the list of expressions
ends with a function call, then all values returned by that call enter the
list of values, before the adjustment (except when the call is enclosed in
parentheses; see §3.4).</blockquote>

There is no observable difference, whether we call `f(1)` or `f(1, nil)`. But
for some functions, there is. Suppose we have

{% highlight lua %}
table.insert(t, g())
{% endhighlight %}

where `t` is a table and `g` is a function that may or may not return a value.
As long as `g` returns a value, including `nil`, everything works as expected.
(We don't mind appending `nil` to a table.)  When `g` happens to return
nothing, `table.insert` complains about a missing argument, which may be
[surprising][2], considering that Lua is supposed to [adjust the number of
arguments to the number of parameters][3]:

{% highlight text %}
stdin:1: wrong number of arguments to 'insert'
stack traceback:
	[C]: in function 'insert'
	stdin:1: in main chunk
	[C]: in ?
{% endhighlight %}

We can introduce a variable

{% highlight lua %}
local b = g()
table.insert(t, b)
{% endhighlight %}

or put parentheses around the call to `g`

{% highlight lua %}
table.insert(t, (g()))
{% endhighlight %}

to force exactly one result, turning nothing into `nil`, as if `g` returned
`nil`. And `nil` is not nothing. All three functions

{% highlight lua %}
function f() end
function g() return end
function h() return nil end
{% endhighlight %}

are interchangeable when used liked this:

{% highlight lua %}
local x = f(); print(x) -- nil
local y = g(); print(y) -- nil
local z = h(); print(z) -- nil
{% endhighlight %}

But only `h` returns `nil`, whereas `f` and `g` return nothing:

{% highlight lua %}
print(f()) --
print(g()) --
print(h()) -- nil
{% endhighlight %}

<!--References-->

[1]: http://www.lua.org/manual/5.2/manual.html#3.3.3
[2]: http://lua-users.org/lists/lua-l/2011-02/msg01444.html
[3]: http://www.lua.org/pil/5.html

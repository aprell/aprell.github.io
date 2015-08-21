---
layout: post
title: "More Lua Gotchas"
date: 2015-02-21 18:49:01 +0100
comments:
categories: [Lua, Programming]
---

Speaking of Lua gotchas, here's another one. Assume you have a simple function
for mapping over tables (sequences):

<!--more-->

{% highlight lua %}
local function map(t, f)
	local m = {}
	for _, v in ipairs(t) do
		table.insert(m, f(v))
	end
	return m
end
{% endhighlight %}

`map` seems to work as expected, for instance,

{% highlight lua %}
map({1, 2, 3}, function (a) return a^2 end)
{% endhighlight %}

returns a table with the numbers 1, 4, and 9. Nice. How about printing each
element of a table? We might consider using something like

{% highlight lua %}
map({1, 2, 3}, print)
{% endhighlight %}

Whoops!

{% highlight text %}
1
lua: nothing.lua:4: wrong number of arguments to 'insert'
stack traceback:
	[C]: in function 'insert'
	nothing.lua:4: in function 'map'
	nothing.lua:10: in main chunk
	[C]: in ?
{% endhighlight %}

Let's see... `table.insert` got the wrong number of arguments and bailed out.
The problem is that `print` has no return value. There's a difference between
returning nothing and returning `nil`, as we convince ourselves:

{% highlight lua %}
map({1, 2, 3}, function (a) print(a); return nil end)
{% endhighlight %}

correctly prints the numbers 1 to 3. To force exactly one result, we can
assign `f(v)` to a variable or put an extra pair of parentheses around the
function call. If `f` is a function that returns nothing, the result will be
`nil`, as if `f` returned `nil` in the first place. Changing `f(v)` to
`(f(v))` in the definition of `map` does the trick, and `map({1, 2, 3},
print)` now works as intended.

To summarize, all three functions

{% highlight lua %}
local function f() end
local function g() return end
local function h() return nil end
{% endhighlight %}

produce a result of `nil` when used liked this:

{% highlight lua %}
local x = f(); print(x) -- nil
local y = g(); print(y) -- nil
local z = h(); print(z) -- nil
{% endhighlight %}

But only `h` does in fact _return_ `nil`, whereas `f` and `g` return nothing:

{% highlight lua %}
print(f()) --
print(g()) --
print(h()) -- nil
{% endhighlight %}

---
layout: post
title: "Lua Gotchas"
date: 2014-12-21 18:26:15 +0100
comments:
categories: [Lua, Programming]
---

Lua is one of my favorite programming languages. Lua is easy to learn, but not
entirely without [gotchas][1] if you're used to other languages. One gotcha is
related to for-loops. What do you think the following piece of code will
print?

<!--more-->

```lua
for i = 1, 5 do
	print(i)
	if i == 3 then i = i + 1 end
end
```

The numbers from one to five except four? Because that's what the equivalent
loop in C++ would print:

```c++
for (int i = 1; i <= 5; i++) {
	std::cout << i << std::endl;
	if (i == 3) i++;
}
```

Except it's not equivalent. Lua's for-loops are implemented in terms of while.
Above example is translated to:

```lua
do
	local _i, _end, _step = 1, 5, 1
	while _i <= _end do
		local i = _i
		print(i)
		if i == 3 then i = i + 1 end
		_i = _i + _step
	end
end
```

Quoting from [Programming in Lua][2]:

<blockquote>The for loop has some subtleties that you should learn in order to
make good use of it. First, all three expressions are evaluated once, before
the loop starts. [...] Second, the control variable is a local variable
automatically declared by the for statement and is visible only inside the
loop. [...] Third, you should never change the value of the control
variable.</blockquote>

<!--References-->

[1]: http://www.luafaq.org/gotchas.html
[2]: http://www.lua.org/pil/4.3.4.html

---
layout: post
title: "Dependent Types in Haskell"
date: 2015-08-20 21:58:46 +0200
comments:
categories: [Haskell, Programming, Types]
---

It looks like GHC is getting closer to supporting dependent types with a patch
that [eliminates the distinction between types and kinds][1]. What is a
dependent type? Perhaps the most accessible introduction I've seen so far is a
recently updated article on the merits of programming with (almost) dependent
types: [Approximate Dependent-Type Programming][2]

<!--more-->

> An ordinary type such as `[a]` may depend on other types -- in our case, the
> types of list elements -- but not on the values of those elements or their
> number. A dependent type does depend on such dynamic values. [...] One
> should distinguish a dependent type (which depends on a dynamic value) from
> a polymorphic type such as `Maybe a`. The type `List n a` from our running
> example is indexed by the value (the list length) and by the type (of its
> elements): it is both dependent (in `n`) and polymorphic (or, technically,
> parametric), in `a`.

In other words, `List n a` is parameterized by a value in addition to a type.

> The different nature of the two arguments in `List n a` has many
> consequences: since the list length `n` is a natural number, one may apply
> to it any operation on natural numbers such as addition, increment,
> multiplication, etc.

The article brings up an interesting example in which the type checker must be
convinced that `List (n+m) a` and `List (m+n) a` are the same type.

> Now, deciding if two types are the same involves determining if two
> expressions are equal, which is generally undecidable (think of functions or
> recursive expressions). There is a bigger problem: in our example, `n` and
> `m` are just variables, whose values will be known only at run-time. The
> type-checker, which runs at compile-time, therefore has to determine that
> `n+m` is equal to `m+n` *without* knowing the concrete values of `n` and
> `m`. We know that natural addition is commutative, but the type-checker does
> not. It is usually not so smart to figure out the commutativity from the
> definition of addition. Therefore, we have to somehow supply the *proof* of
> the commutativity to the type-checker. Programming with dependent types
> involves a great deal of theorem proving.

<!--References-->

[1]: https://typesandkinds.wordpress.com/2015/08/19/planned-change-to-ghc-merging-types-and-kinds
[2]: http://okmij.org/ftp/Haskell/dependent-types.html

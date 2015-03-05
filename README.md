#API
Family.rkt uses [`racklog`][racklog] (a Prolog like language library) to describe vertex to vertex relationships in trees using some of the language for family trees.

	;; Family.rkt
	#lang racket

	;; Dependency
	(require racklog)

##Primary Predicates
The API provides three primary predicates:

`%Parent` is the primary relationship. The vertex `u` is the *parent* of vertex `v` if there is a directed edge `u -> v`.

`%Atom` describes a vertex `u` such that the graph does not contain any directed edge `u -> v`.

`%Root` describes a vertex `u` such that the graph does not contain any directed edge `v -> u`.

	;; Primary Predicate
	(provide %Parent
	         %Atom
	         %Root)

The constructors for `%Parent`, `%Atom`, and `%Root` relations entail mutation of underlying data structures. Their nomenclature reflects that with Scheme's traditional `!`.

	;; Primary Predicate Constructor
	(provide %Parent!
	         %Atom!
	         %Root!)


##Secondary Predicates
The secondary predicates describe existing relationships based exclusively on the instantiations of the **Primary Predicates**.


	;; Secondary Predicate
	(provide %Child
             %Sibling
             %Ancestor
             %Descendent)

`%Child` describes a vertex `u` such that there exists a vertex `v` that is the parent of `u`.

`%Sibling` describes a vertices `u` and `v` such that there exists a vertex `w` where `w` is the parent of `u` and `w` is the parent of `v`.

`%Ancestor` describes a vertex `u` such that `u` is the parent of `v` or `u` is an `%Ancestor` of `v`'s parent.

`%Desendent` describes a vertex `u` such that `u` is the child of `v` or `u` is a `%Desendent` of one of `v`'s children.


##Example
	;; Test-family.rkt

    #lang racket

	(require racklog)

	(require "Family.rkt")

	(%Parent! 'a 'b1)
	(%Parent! 'a 'b2)
	(%Parent! 'b1 'c)

	(%which (what)
        (%Parent what 'b1))

	(%which (what)
        (%Child what 'b1))

	(%which (what)
        (%Sibling what 'b2))



[racklog]: http://docs.racket-lang.org/racklog/index.html


    


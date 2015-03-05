
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



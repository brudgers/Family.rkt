;; Family.rkt
#lang racket

;; Dependency
(require racklog)


;; Primary Predicate
(provide %Parent 
         %Root   
         %Atom)

;; Primary Predicate Constructor
(provide %Parent!
         %Root! 
         %Atom!)

;; Secondary Predicate
(provide %Child
         %Sibling
         %Ancestor
         %Descendent)

;; -----
;; Primary Predicate

;; A tree should have only one Root
(define %Root
  (%rel (X)))

(define (%Root! root)
  (if (not(%which(y)(%Parent y root)))
      (%assert! %Root()((root)))
      (error '%Root! "failed because ~a has %Parent" root)))

;; An atom returns itself
(define %Atom
  (%rel (X)))

(define (%Atom! atom)
        (if (not (%which (child) (%Child child atom)))
            (%assert! %Atom()((atom)))
            (error '%Atom! "failed because ~a has %Child" atom)))

;; The Principle relation is the Parent
(define %Parent
  (%rel (X Y)))

(define (%Parent! parent child)
  (if (not (%which ()(%Ancestor child parent)))
      (if (not (%which()(%Descendent child parent)))
          (%assert! %Parent()((parent child)))
          (error '%Parent "failed because ~a already a descendent of ~s" child parent))
      (error '%Parent "failed because ~a is an anscestor of ~s" child parent)))
      
;; -----
;; Secondary Relations
(define %Child
  (%rel (X Y)
        [(X Y)
         (%Parent Y X)]))

(define %Sibling
 (%let (what)
       (%rel (left right)
             [(left right)
              (%Parent what left)
              (%Parent what right)])))

(define %Ancestor
  (%let (X)
    (%rel (Y Z)
          [(Y Z)
           (%Parent Y Z)]
          [(Y Z)
           (%Parent Y X)
           (%Parent X Z)])))

(define %Descendent
  (%let (X)
    (%rel (Y Z)
          [(Y Z)
           (%Child Y Z)]
          [(Y Z)
           (%Child Y X)
           (%Child X Z)])))



        


                         

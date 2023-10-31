; Another technique to accomplish information hiding in R5RS Scheme.
; Chris Pressey, Jan 2023.

(define new-stack
  (letrec ( (make-stack (lambda (items)
                          (lambda (op args)
                            (cond
                               ((equal? op 'push)
                                (let* ( (item (car args))
                                        (new-items (cons item items)) )
                                  (make-stack new-items)))
                               ((equal? op 'top)
                                 (car items))
                               ((equal? op 'popped)
                                 (make-stack (cdr items)))
                            ))))
          )
    (lambda () (make-stack '())))
)

;
; A transcript of some sample usage
;
; #;1> (define s (new-stack))
; #;2> (define t (s 'push '(4)))
; #;3> (define u (t 'push '(5)))
; #;4> (u 'top '())
; 5
; #;5> ((u 'popped '()) 'top '())
; 4

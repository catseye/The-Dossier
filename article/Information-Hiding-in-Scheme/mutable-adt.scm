; Another technique to accomplish information hiding in R5RS Scheme,
; this one encapsulating a mutable ADT with an OO-like dispatch.
; Chris Pressey, Jan 2023.

(define new-stack
  (lambda ()
    (let* ((stack '()))
      (lambda (method args)
        (cond
          ((equal? method 'push)
            (begin
              (set! stack (cons (car args) stack))
              #t))
          ((equal? method 'top)
            (car stack))
          ((equal? method 'pop)
            (begin
              (set! stack (cdr stack))
              #t)))))))

;
; A transcript of some sample usage
;
; #;1> (define s (new-stack))
; #;2> (s 'push '(4))
; #t
; #;3> (s 'push '(5))
; #t
; #;4> (s 'top '())
; 5
; #;5> (s 'pop '())
; #t
; #;6> (s 'top '())
; 4

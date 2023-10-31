; A simple technique to accomplish information hiding in R5RS Scheme.
; Chris Pressey, May 2021.

(define stack-module (lambda ()
  (let* ((secret-token (list 1))
         (seal         (lambda (data)
                         (lambda (token)
                           (if (eq? token secret-token)
                             data
                             'an-error-occurred))))
         (open         (lambda (opaque-object)
                         (opaque-object secret-token)))

         (new-stack    (lambda ()
                         (seal '())))
         (is-empty?    (lambda (stack)
                         (equal? (open stack) '())))
         (push         (lambda (stack item)
                         (let* ((data      (open stack))
                                (new-data  (cons item data))
                                (new-stack (seal new-data)))
                           new-stack)))
         (top          (lambda (stack)
                         (car (open stack))))
         (popped       (lambda (stack)
                         (let* ((data      (open stack))
                                (new-data  (cdr data))
                                (new-stack (seal new-data)))
                           new-stack))))
    (list new-stack is-empty? push top popped))))

(define skm       (stack-module))
(define new-stack (car skm))
(define is-empty? (cadr skm))
(define push      (caddr skm))
(define top       (cadddr skm))
(define popped    (car (cddddr skm)))

;
; A transcript of some sample usage that shows that it implements a stack:
;
; #;1> (define s (new-stack))
; #;2> (define t (push s 4))
; #;3> (define u (push t 5))
; #;4> (top u)
; 5
; #;5> (top (popped u))
; 4
; #;6> (is-empty? s)
; #t
; #;7> (is-empty? (popped t))
; #t
; #;8> (popped s)
;
; Error: (cdr) bad argument type: ()
;

;
; And a transcript that shows that it hides the representation:
;
; #;8> s
; #<procedure (? token)>
; #;9> t
; #<procedure (? token)>
; #;10> top
; #<procedure (top stack)>
; #;11> (s 1)
; an-error-occurred
; #;12> (s (list 1))
; an-error-occurred
; #;13> (is-empty? (list 1))
;
; Error: call of non-procedure: (1)
;

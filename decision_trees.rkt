#lang racket

(struct Gnode (val lst) #:transparent)

(struct Dnode (vobs vattr lobs lattr ltar lst))

(struct Dleaf (vobs vtar))

(define attributes1 '(x y z))

(define examples1 '(1 2 3 4 5 6))

(define target1 '(1 1 0 1 0 0))

(define obs-table1 (list (list "a" "b" "b" "a" "a" "b")
                         (list "some" "none" "full" "full" "some" "full")
                         (list "1" "1" "2" "2" "3" "3")))

(define attributes2 '("Alternate" "Bar" "Fri/Sat" "Hungry" "Patrons" "Price" "Raining" "Reservation" "Type" "WaitEstimate"))

(define examples2 '(1 2 3 4 5 6 7 8 9 10 11 12))

(define target2 '(1 0 1 1 0 1 0 1 0 0 0 1))

(define obs-table2 (list (list "Yes" "Yes" "No" "Yes" "Yes" "No" "No" "No" "No" "Yes" "No" "Yes")
                         (list "No" "No" "Yes" "No" "No" "Yes" "Yes" "No" "Yes" "Yes" "No" "Yes")
                         (list "No" "No" "No" "Yes" "Yes" "No" "No" "No" "Yes" "Yes" "No" "Yes")
                         (list "Yes" "Yes" "No" "Yes" "No" "Yes" "No" "Yes" "No" "Yes" "No" "Yes")
                         (list "Some" "Full" "Some" "Full" "Full" "Some" "None" "Some" "Full" "Full" "None" "Full")
                         (list "$$$" "$" "$" "$" "$$$" "$$" "$" "$$" "$" "$$$" "$" "$")
                         (list "No" "No" "No" "No" "No" "Yes" "Yes" "Yes" "Yes" "No" "No" "No")
                         (list "Yes" "No" "No" "No" "Yes" "Yes" "No" "Yes" "No" "Yes" "No" "No")
                         (list "French" "Thai" "Burger" "Thai" "French" "Italian" "Burger" "Thai" "Burger" "Italian" "Thai" "Burger")
                         (list "0-10" "30-60" "0-10" "10-30" ">60" "0-10" "0-10" "0-10" ">60" "10-30" "0-10" "30-60")))

(define attributes3 '("Mass(kgs)" "Wheel base(mm)" "Width(mm)" "Height(mm)" "Length(mm)" "Angle(degrees)" "Speed(km/hr)" "Angular Velocity(degrees/s)" "Acceleration(km/hr^2)" "Angular Acceleration(degrees/hr^2)"))

(define examples3 '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30))

(define target3 '(1 0 1 1 0 1 0 1 0 0 0 1 1 0 1 1 0 1 0 1 0 0 0 1 1 0 1 1 0 1))

(define obs-table3 (list (list "1900-2200" "1300-1600" "1000-1300" "1900-2200" "2200-2500" "<1000" "1300-1600" "2200-2500" "1300-1600" "1000-1300" ">2500" "1900-2200" "2200-2500" ">2500" "1300-1600" "1600-1900" "<1000" "1000-1300" "1900-2200" ">2500" "1900-2200" "1000-1300" "1300-1600" "<1000" "1300-1600" "1600-1900" "2200-2500" "1600-1900" ">2500" "1600-1900")
                         (list "2400-2600" "<2400" "2400-2600" ">2600" "<2400" "<2400" "2400-2600" ">2600" "<2400" "2400-2600" ">2600" "<2400" "2400-2600" ">2600" "<2400" ">2600" "2400-2600" ">2600" "<2400" "2400-2600" ">2600" "<2400" ">2600" "2400-2600" "2400-2600" ">2600" "<2400" ">2600" "2400-2600" "<2400")
                         (list "1500-1700" "<1500" "1900-2100" "<1500" "1700-1900" "1900-2100" "1500-1700" "1500-1700" "1700-1900" "<1500" "1900-2100" "1700-1900" "1700-1900" "1900-2100" ">2100" "<1500" "1500-1700" "1700-1900" ">2100" "<1500" "1700-1900" ">2100" "1900-2100" "1700-1900" ">2100" "1500-1700" "<1500" ">2100" "1500-1700" ">2100")
                         (list "<1300" "1300-1500" "1500-1700" "1300-1500" "<1300" "2100-2300" "1500-1700" "2100-2300" "1300-1500" "<1300" "1300-1500" "2100-2300" "1500-1700" "1700-1900" "1700-1900" "1700-1900" "2100-2300" "<1300" "1900-2100" "<1300" "1900-2100" "1700-1900" "1900-2100" "1500-1700" "1900-2100" "1700-1900" "1900-2100" "2100-2300" ">2300" "1700-1900")
                         (list "<3700" "3700-3900" "3900-4100" ">4100" "<3700" "3700-3900" "3900-4100" ">4100" "<3700" "3700-3900" "3900-4100" ">4100" "<3700" "3700-3900" "3900-4100" ">4100" "<3700" "3700-3900" "3900-4100" ">4100""<3700" "3700-3900" "3900-4100" ">4100""<3700" "3700-3900" "3900-4100" ">4100""<3700" "3700-3900")
                         (list "<30" "30-60" "60-90" ">90" "<30" "30-60" "60-90" ">90" "<30" "30-60" "60-90" ">90" "<30" "30-60" "60-90" ">90" "<30" "30-60" "60-90" ">90" "<30" "30-60" "60-90" ">90" "<30" "30-60" "60-90" ">90" "<30" "30-60")
                         (list "<30" "30-60" "60-90" "90-120" "120-150" ">150" "<30" "30-60" "60-90" "90-120" "120-150" ">150" "<30" "30-60" "60-90" "90-120" "120-150" ">150" "<30" "30-60" "60-90" "90-120" "120-150" ">150" "<30" "30-60" "60-90" "90-120" "120-150" ">150")
                         (list "<5" "5-10" ">10" "<5" "5-10" ">10" "<5" "5-10" ">10" "<5" "5-10" ">10" "<5" "5-10" ">10" "<5" "5-10" ">10" "<5" "5-10" ">10" "<5" "5-10" ">10" "<5" "5-10" ">10" "<5" "5-10" ">10")
                         (list "<2" "2-4" "4-6" "6-8" ">8" "<2" "2-4" "4-6" "6-8" ">8" "<2" "2-4" "4-6" "6-8" ">8" "<2" "2-4" "4-6" "6-8" ">8" "<2" "2-4" "4-6" "6-8" ">8" "<2" "2-4" "4-6" "6-8" ">8")
                         (list "<2" "2-4" ">4" "<2" "2-4" ">4" "<2" "2-4" ">4" "<2" "2-4" ">4" "<2" "2-4" ">4" "<2" "2-4" ">4" "<2" "2-4" ">4" "<2" "2-4" ">4" "<2" "2-4" ">4" "<2" "2-4" ">4")))

(define (pos atb t-atb)
  (+ (index-of atb t-atb) 1))

(define (nos1 l)
  (count (lambda (x) (equal? 1 x)) l))

(define (nos0 l)
  (count (lambda (x) (equal? 0 x)) l))

(define (contain-one l)
  (cond[(null? l) #t]
       [(equal? (car l) 1) (and #t (contain-one (cdr l)))]
       [else #f]))

(define (contain-zero l)
  (cond[(null? l) #t]
       [(equal? (car l) 0) (and #t (contain-zero (cdr l)))]
       [else #f]))

(define (possible-observations l)
  (cond[(null? l) '()]
       [(cons (remove-duplicates (car l)) (possible-observations (cdr l)))]))

(define (expected-entropy obs p-obs tar n)
  (cond[(equal? n 1) (entropy-values (car obs) (car p-obs) tar) ]
       [(expected-entropy (cdr obs) (cdr p-obs) tar (- n 1))]))

(define (entropy l)
  (let([a (/ (nos1 l) (length l))] [b (/ (nos0 l) (length l))])
    (cond[(or (equal? 0 a) (equal? 0 b)) 0]
         [else (-(+ (* a (log a 2)) (* b (log b 2))))])))

(define (entropy-values ca-obs ca-p-obs tar)
  (cond[(null? ca-p-obs) 0]
       [(let ([ a (/ (count (lambda (x) (equal? x (car ca-p-obs))) ca-obs) (length ca-obs))]
              [b (remove* (list (void)) (map (lambda (x y) (cond[(equal? x (car ca-p-obs)) y])) ca-obs  tar))])
          (+ (* a (entropy b)) (entropy-values ca-obs (cdr ca-p-obs) tar)))]))

(define (information-gain obs tar n)
  (- (entropy tar) (expected-entropy obs (possible-observations obs) tar n)))

(define (pos-max-info lobs lattr ltar)
  (let*([a (range 1 (+ 1 (length lattr)))]
        [b (map (lambda (x) (information-gain lobs ltar x)) a)])
    (pos b (foldl max 0 b))))

(define (max-info-tree lobs lattr ltar)
  (let*([n (pos-max-info lobs lattr ltar)]
        [lpobs (possible-observations lobs)]
        [lst (map (lambda (x) (list x (get-ltar x lobs ltar n))) (list-ref lpobs (- n 1)))])
    (Gnode (list-ref lattr (- n 1)) lst)))

(define (get-lattr lattr n)
  (remove (list-ref lattr (- n 1)) lattr))

(define (get-ltar a lobs ltar n)
  (remove* (list (void)) (map (lambda (x y) (cond[(equal? x a) y])) (list-ref lobs (- n 1))  ltar)))

(define (get-lobs1 lobs n)
  (remove (list-ref lobs (- n 1)) lobs))

(define (get-lobs2 a lobs ltar n)
  (map (lambda (x y) (cond[(equal? x a) y])) (list-ref lobs (- n 1))  ltar))

(define (get-lobs3 lobs ltar n )
  (let([lpobs (possible-observations lobs)])
    (map (lambda (x) (list x (get-lobs2 x lobs ltar n))) (list-ref lpobs (- n 1)))))

(define (get-lobs4 l lobs)
  (cond[(null? lobs) '()]
       [(list*(remove* (list void) (map (lambda (x y) (cond[(equal? x 1) y]
                                                           [(equal? x 0) y]
                                                           [void])) l (car lobs))) (get-lobs4 l (cdr lobs)))]))

(define (get-lobs vobs lobs ltar n)
  (let*([l3 (get-lobs3 lobs ltar n )][l1 (get-lobs1 lobs n)])
    (car (remove* (list (void))(map (lambda (x) (cond[(equal? (car x) vobs)(get-lobs4 (cadr x) l1)])) l3)))))

(define (decision-tree lobs lattr ltar)
  (let ([t1 (max-info-tree lobs lattr ltar)][n (pos-max-info lobs lattr ltar)])
    (match t1 [(Gnode vattr lst) (Gnode vattr (map (lambda (x) (cond[(contain-zero (cadr x)) (list (car x) 0)]
                                                                    [(contain-one (cadr x)) (list (car x) 1)]
                                                                    [(list (car x) (decision-tree (get-lobs (car x) lobs ltar n) (get-lattr lattr n) (cadr x)))])) lst))])))

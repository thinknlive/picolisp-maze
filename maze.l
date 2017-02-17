# vi:et:ts=3:sw=3

# -------------------------------------------------------------------
# Binary encode given number.
#   Return list of 0,1 digits msb..lsb
#   Use Opt to:
#      pad to 8-bit boundary
#      reverse bit order lsb..msb
# 
# (if (car Opt) "pad to 8 bit boundary")
# (if (cdr Opt) "reverse the bits ie lsb..msb") 

#: (pp 'byte2bin)      
(de byte2bin (N Opt)
   (let (V NIL  C 0)
      (setq N (chop (bin N)))
      (mapcar
         '((B)
            (inc 'C)
            (setq V (cons (format B) V)) )
         N )
      (setq V (flip V))
      (if (car Opt)
         (while (<> 0 (% C 8))
            (setq V (cons 0 V))
            (inc 'C) ) )
      (if (car (cdr Opt)) (setq V (flip V)))
      V ) )


# -------------------------------------------------------------------
# Generate a maze from N bytes of current input channel
#   N - Number of bytes to read from channel, T=all
#   W - Number of characters per line, NIL=one line
#   C - List of symbols to use '(bit0 bit1 '(sep0 sep1)
#   Opt - Options for byte encoding '(T=8bit | NIL=min bits . T=lsb-msb | NIL=msb-lsb)
# Default is to print UTF-8 diagonals

(de amaze (N W C Opt)
   (let
      (C0 (or (car C) "╱")
         C1 (or (cadr C) "╲")
         CF0 (car (caddr C))
         CF1 (cadr (caddr C))
         M 0
         I 0
         P
         '((X)
            (if (and (gt0 W) (=0 (% I W)))
               (wr 10) )
            (cond
               ((=0 X) (prin C0))
               ((=1 X) (prin C1))
               (T (prin X)) )
            (inc 'I) ) )
      (default N T)
      (while
         (and
            (or (== N T) (gt0 N))
            (rd 1) )
         (mapcar
            '((X) (P X) (inc 'M))
            (byte2bin @ Opt) )
        (if (gt0 (% M 8))
          (case (rand 1 2)
             (1 (and CF0 (P CF0)))
             (2 (and CF1 (P CF1))) ) )
        (if (gt0 N) (dec 'N)) ) ) )

# -------------------------------------------------------------------

(de bmaze (N W C Opt )
   (let
      (C0 (or (car C) "/")          # Bit 0
         C1 (or (cadr C) "\\")      # Bit 1
         CF0 (car (caddr C))        # Byte Separator 1
         CF1 (cadr (caddr C))       # Byte Separator 0
         M 0                        # When to write separator
         I 0                        # When to write newline
         P                          # Write 'bit' to output channel
         '((X)
            (if (and (gt0 W) (=0 (% I W)))
               (wr 10) )
            (cond
               ((=0 X) (wr (char C0)))
               ((=1 X) (wr (char C1)))
               (T (wr (char X))) )
            (inc 'I) ) )
            (default N T)
            (while
               (and
                  (or (== N T) (gt0 N))
                  (rd 1) )          # Read byte from input channel
               (mapcar              # Convert to 'bits' and write output channel
                  '((X) (P X) (inc 'M))
                  (byte2bin @ Opt) )
               (if (gt0 (% M 8))    # If <8bit bytes, write separator
                  (case (rand 1 2)
                     (1 (and CF0 (P "-")))
                     (2 (and CF1 (P "+"))) ) )
               (if (gt0 N) (dec 'N)) ) ) )

# -------------------------------------------------------------------
# Sample runs

#: (out "/mnt/vboxsf/test.80.txt" (in "/usr/lib/picolisp/bin/picolisp" (maze8 T 32 '("\9523\" "\9531\" ("\9547\" "\9547\")) '(NIL . T)))) 
#-> NIL
#: (out "/mnt/vboxsf/test.81.txt" (in "/usr/lib/picolisp/bin/picolisp" (maze8 T 32 '("\9507\" "\9515\" ("\9547\" "\9547\")) '(NIL . T)))) 
#-> NIL
#: (out "/mnt/vboxsf/test.82.txt" (in "/usr/lib/picolisp/bin/picolisp" (maze8 T 32 '("\9589\" "\9591\" ("\9593\" "\9595\")) '(NIL . T))))
#-> NIL
#: (out "/mnt/vboxsf/test.83.txt" (in "/usr/lib/picolisp/bin/picolisp" (maze8 T 32 '("\9585\" "\9586\" ("\9587\")) '(NIL . T))))          
#-> NIL
#: (out "/mnt/vboxsf/test.84.txt" (in "/usr/lib/picolisp/bin/picolisp" (maze8 T 32 '("\9585\" "\9586\") '(T . T))))                       
#-> NIL

# -------------------------------------------------------------------
# Generate a list of random byte values
#(let (B NIL) (in "/dev/urandom" (do 1024 (setq B (cons (rd 1) B)))))

#(nil (in "explore-20170216.l" 
#  (do 256 
#     (mapcar '((X) (wr (char (if (=0 X) "/" "\\")))) 
#        (byte2bin (rd 1))))))

# convert binary list back into integer value
#(let (V 0 S 1) (mapcar '((X) (setq V (+ V (* (format X)  S)) S (* S 2))) (flip (chop (bin 200)))) V )

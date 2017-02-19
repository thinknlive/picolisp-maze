# vi:et:ts=3:sw=3

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
         CF0 (or (car (caddr C)) " ")
         CF1 (or (cadr (caddr C)) CF0)
         M 0
         I 0
         Put
         '((X)
            (if
               (and
                  (gt0 W)
                  (gt0 I)
                  (=0 (% I W)) )
               (prin "^J") )
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
            '((X) (Put X) (inc 'M))
            (byte2bin @ Opt) )
         (if (gt0 (% M 8))
            (case (rand 1 2)
               (1 (and CF0 (Put CF0)))
               (2 (and CF1 (Put CF1))) ) )
         (if (gt0 N) (dec 'N)) ) ) )

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
(de rmaze (Bit0 Bit1)
   (let
      (C NIL
         Byte nil
         N 0
         Cat
         '((B)
            (setq Byte (if Byte (cons B Byte) (list B)))
            (inc 'N) )
         Put
         '(NIL
            (let (V (bin2byte Byte))
               (nil (prin "[" Byte " " V " " (char V) "]"))
               (and Byte (wr V))
               (setq Byte NIL  N 0) ) ) )
      (while (setq C (char))
         (if (and (gt0 N) (=0 (% N 8)))
            (Put) )
         (cond
            ((= C Bit0) (Cat 0))
            ((= C Bit1) (Cat 1))
            ((= C "^J") T)
            (T (Put)) ) )
      (and Byte (Put)) ) )

# -------------------------------------------------------------------
(de bin2byte (L)
   (let (V 0  S 1)
      (mapcar
         '((X)
            (setq
               V (+ V (* X S))
               S (* S 2) ) )
         (reverse L) )
      V ) )

# -------------------------------------------------------------------
# Test

#: (out "test.enc.txt" (in "afn-the-function-of-reason.txt" (amaze T 96 '("0" "1" (":")) '(NIL . T))))
#-> NIL
#: (out "test.dec.txt" (in "test.enc.txt" (rmaze "0" "1")))                                           
#-> NIL
#: (call 'md5sum  "afn-the-function-of-reason.txt")
#f1c2d163c7eb6f087d199e69741b5850  afn-the-function-of-reason.txt
#-> T
#: (call 'md5sum  "test.dec.txt")                  
#f1c2d163c7eb6f087d199e69741b5850  test.dec.txt

# Test different patterns
#: (out "test.enc.txt" (in "afn-the-function-of-reason.txt" (maze8 T 32 '("\9523\" "\9531\" ("\9547\" "\9547\")) '(NIL . T)))) 
#: (out "test.enc.txt" (in "afn-the-function-of-reason.txt" (maze8 T 32 '("\9507\" "\9515\" ("\9547\" "\9547\")) '(NIL . T)))) 
#: (out "test.enc.txt" (in "afn-the-function-of-reason.txt" (maze8 T 32 '("\9589\" "\9591\" ("\9593\" "\9595\")) '(NIL . T))))
#: (out "test.enc.txt" (in "afn-the-function-of-reason.txt" (maze8 T 32 '("\9585\" "\9586\" ("\9587\")) '(NIL . T))))          
#: (out "test.enc.txt" (in "afn-the-function-of-reason.txt" (maze8 T 32 '("\9585\" "\9586\") '(T . T))))                       

# -------------------------------------------------------------------
# Generate a list of random byte values
#(let (B NIL) (in "/dev/urandom" (do 1024 (setq B (cons (rd 1) B)))))

#(nil (in "explore-20170216.l" 
#  (do 256 
#     (mapcar '((X) (wr (char (if (=0 X) "/" "\\")))) 
#        (byte2bin (rd 1))))))



# picolisp-maze
(de amaze)
(de rmaze)

When you get carried away with '10 PRINT'...

~~~~
(let (V 47) (do NIL (wr (x| V (* (rand 0 1) 115)))))
\\//\//\//\\///\//\/\\/\//\\\\\//\\/\//\///////\\\\/\/\\/\/\
//////\\//\//\/\\\/\/\\\////\\\\\\/\\//\/\\\//\//\//\/////\/
\///\/\\/\\\\/\\/\//\/\\//\///\//\//\\\\/\\//\/\/\\//\//\//\-> 92

(do NIL (wr (or (gt0 (* (rand 0 1) 47)) 92)))
/\/\\\/\\/\\\\//\\//\\/\\\\\\\///\\\\\/\\\\\\\/\//\/\\////\//
\//\/\\/\//\///\//\//\/\//\/\\//\//\/\\/\/\//\\\\///\/\/\//\\
////\\\\\\\////\/\\/\\\/\\\//\/\/\/\\\/\\\//\//\///\/\//\//\/
/\\//\\/\////\\//\\/////////\////\/\/\\\/\/\\\//\/\/\/\\//\\\

(in "/dev/urandom" (amaze 32 32 '("." ":" ("|" "|")) '(T . T)))   

::.:::..:...:....::..::..:......
::.:...:......:::::...:.....:...
..:.:.:::.::.......:....:::.:.:.
:.....:......:::.:...::........:
::::.:.:::::.:::.::.::.....:.:..
:.:..:...:::..:....:::::.:.::...
..:..::..:.:..::...:.:.::::.::.:
:::::::...:..:.::..:..::::......
~~~~

Encode a stream to a maze and reverse...

~~~~

: (load "maze.l")                                                                                                 
-> bin2byte
: (out "enc.txt" (in "afn-the-function-of-reason.txt" (amaze T 96 '(("." ":") ("~" "-") ("_" "'")) '(NIL . T))))  
-> NIL
: (in "enc.txt" (do 512 (prin (char))))                                                                         
.:-.-.~_..:-:--_-.~:.--_..::.~':-~.:.~_~.-:~~~':---.~~'-~:.:~~_:.~.~-~'-::-:--_~-~~:--_:~~-:~-_.
::.:-'~~~~:~~_:-~:.--_:.:::-':~.:~.-'-.~:.~-'~:..:-~_-~:.--~'-~~-:~~'.~-~.~~'.-.-_.:~-:.~'~~~-.~
-'~:~:~-~'~::~:--_~-:.~-~_:.:::-'~-::::~'..--:--'-.:.:~~_:-..~-~_~~:-.-~':...:-':~-.~:~'-..:.~~'
.~~~.--_-:-:~-~_:::-~~~'~.-.:--'~.--:~~_::::.~'.~~:::-_~~--.-~'~.-:---_:~--:--_.:-:.~-_-:...--_.
:~.---'~:.~:-~'~-~~:~~'.--~:~-_:...:~_.:~~:.~_~.~::--_-~...~~'::-.~~-'-.-:---_:-..~--_-.~:.~~_~~
::--~'.~.~'.:.:-:-_:-..~~~_-> "_"
: (out "dec.txt" (in "enc.txt" (rmaze '(("." ":") ("~" "-")))))                                                 
-> NIL
: (call 'md5sum "afn-the-function-of-reason.txt")                                                               
f1c2d163c7eb6f087d199e69741b5850  afn-the-function-of-reason.txt
-> T
: (call 'md5sum "dec.txt")                                                                                      
f1c2d163c7eb6f087d199e69741b5850  dec.txt
-> T
: (bye)                        

~~~~

Other mazes...

~~~~

(out "maze.10.txt" (in "afn-the-function-of-reason.txt" 
    (amaze T 32 '("\9523\" "\9531\" ("\9547\" "\9547\")) '(NIL . T))))

╱╱╲╱╲╱╲╱╱╱╱╲╱╲╲╱╲╱╲╱╱╲╲╱╱╱╱╱╱╲╱╱
╱╲╲╱╱╱╲╱╲╱╲╱╲╲╲╱╱╲╲╲╱╲╲╱╲╲╱╱╱╲╲╱
╱╱╲╱╲╲╲╱╲╱╱╲╱╲╲╱╲╲╲╲╱╲╲╱╱╲╲╲╱╲╲╱
╱╱╱╱╱╲╱╱╲╲╲╲╱╲╲╱╱╲╲╱╱╲╲╱╱╱╱╱╱╲╱╱
╱╲╱╱╲╱╲╱╲╱╲╱╱╲╲╱╲╱╱╱╱╲╲╱╲╲╱╱╲╲╲╱
╲╲╲╲╱╲╲╱╱╲╲╲╱╲╲╱╱╲╱╲╱╱╱╱╱╱╲╲╱╱╲╱
╲╲╲╲╱╲╲╱╲╱╲╱╲╲╲╱╲╱╱╲╱╲╲╱╲╲╱╱╲╲╲╱
╱╱╱╱╱╲╱╱╲╲╱╱╱╱╲╱╱╱╲╲╱╲╲╱╲╱╱╱╱╲╲╱

(out "maze.11.txt" (in "afn-the-function-of-reason.txt" 
    (amaze T 32 '("\9507\" "\9515\" ("\9547\" "\9547\")) '(NIL . T))))

╱╱╲╱╲╱╲╱╱╱╲╱╲╲╲╱╲╱╱╲╲╱╱╱╱╱╲╱╲╲╱╱
╱╲╳╲╱╲╱╲╲╲╳╱╲╲╲╱╲╲╲╲╱╱╱╲╲╳╱╱╲╱╲╲
╲╲╱╱╲╱╲╲╳╲╲╲╲╱╲╲╳╱╲╲╲╱╲╲╱╱╱╱╱╲╳╲
╲╲╲╱╲╲╱╲╲╱╱╲╲╱╱╱╱╱╲╳╱╲╱╱╲╱╲╳╲╱╲╱
╱╲╲╲╱╱╱╱╲╲╲╲╱╱╲╲╲╳╲╲╲╲╱╲╲╱╲╲╲╱╲╲
╱╲╱╲╳╱╱╲╲╱╱╲╳╲╲╲╲╱╲╲╲╱╲╱╲╲╲╲╱╱╲╱
╲╲╲╲╱╱╲╲╲╳╱╱╱╱╱╲╳╲╲╱╱╱╱╲╳╱╱╲╲╱╲╲

(out "maze.12" (in "afn-the-function-of-reason.txt" 
    (amaze T 32 '("\9589\" "\9591\" ("\9593\" "\9595\")) '(NIL . T))))

╵╵╷╵╷╵╷╻╵╵╵╷╵╷╷╹╷╵╷╵╵╷╷╹╵╵╵╵╵╷╹╵
╷╷╵╵╵╷╹╷╵╷╵╷╷╷╹╵╷╷╷╵╷╷╷╷╵╵╵╷╷╹╵╵
╷╵╷╷╷╹╷╵╵╷╵╷╷╻╷╷╷╷╵╷╷╻╵╷╷╷╵╷╷╹╵╵
╵╵╵╷╹╷╷╷╷╵╷╷╵╷╷╵╵╷╷╻╵╵╵╵╵╷╻╵╷╵╵╷
╵╷╹╷╵╷╵╵╷╷╻╷╵╵╵╵╷╷╹╷╷╵╵╷╷╷╹╷╷╷╷╵
╷╷╵╷╷╷╵╷╷╹╵╷╵╷╹╵╵╷╷╵╵╷╻╷╷╷╷╵╷╷╻╷
╵╷╵╷╷╷╷╵╵╷╵╷╷╻╷╷╵╵╷╷╷╹╵╵╵╵╵╷╻╷╷╵

(out "maze.13.txt" (in "afn-the-function-of-reason.txt" 
    (amaze T 32 '("\9585\" "\9586\" ("\9587\")) '(NIL . T))))         

┣┣┫┣┫┣┫╋┣┣┣┫┣┫┫╋┫┣┫┣┣┫┫╋┣┣┣┣┣┫╋┣
┫┫┣┣┣┫╋┫┣┫┣┫┫┫╋┣┫┫┫┣┫┫┫┫┣┣┣┫┫╋┣┣
┫┣┫┫┫╋┫┣┣┫┣┫┫╋┫┫┫┫┣┫┫╋┣┫┫┫┣┫┫╋┣┣
┣┣┣┫╋┫┫┫┫┣┫┫┣┫┫┣┣┫┫╋┣┣┣┣┣┫╋┣┫┣┣┫
┣┫╋┫┣┫┣┣┫┫╋┫┣┣┣┣┫┫╋┫┫┣┣┫┫┫╋┫┫┫┫┣
┫┫┣┫┫┫┣┫┫╋┣┫┣┫╋┣┣┫┫┣┣┫╋┫┫┫┫┣┫┫╋┫
┣┫┣┫┫┫┫┣┣┫┣┫┫╋┫┫┣┣┫┫┫╋┣┣┣┣┣┫╋┫┫┣

(out "maze.14.txt" (in "afn-the-function-of-reason.txt" 
    (amaze T 32 '("\9585\" "\9586\") '(T . T))))                      

┳┳┻┳┻┳┻╋┳┳┳┻┳┻┻╋┻┳┻┳┳┻┻╋┳┳┳┳┳┻╋┳
┻┻┳┳┳┻╋┻┳┻┳┻┻┻╋┳┻┻┻┳┻┻┻┻┳┳┳┻┻╋┳┳
┻┳┻┻┻╋┻┳┳┻┳┻┻╋┻┻┻┻┳┻┻╋┳┻┻┻┳┻┻╋┳┳
┳┳┳┻╋┻┻┻┻┳┻┻┳┻┻┳┳┻┻╋┳┳┳┳┳┻╋┳┻┳┳┻
┳┻╋┻┳┻┳┳┻┻╋┻┳┳┳┳┻┻╋┻┻┳┳┻┻┻╋┻┻┻┻┳
┻┻┳┻┻┻┳┻┻╋┳┻┳┻╋┳┳┻┻┳┳┻╋┻┻┻┻┳┻┻╋┻
┳┻┳┻┻┻┻┳┳┻┳┻┻╋┻┻┳┳┻┻┻╋┳┳┳┳┳┻╋┻┻┳

(in "/dev/urandom" (amaze 32 32 '("\9523\" "\9531\" ("\9547\" "\9547\")) '(T . T)))  

┳┳┻┻┳┳┻┳┻┻┻┻┻┳┳┻┳┻┳┻┳┻┻┳┳┻┳┳┻┳┳┳
┳┻┳┳┻┳┳┻┻┳┻┳┻┳┳┳┻┳┻┳┳┻┻┳┻┳┳┳┳┳┳┳
┳┻┳┻┻┻┳┻┻┻┻┳┳┻┳┻┳┳┻┳┳┳┻┻┻┳┳┳┻┻┻┻
┳┳┳┻┻┳┳┳┻┳┳┳┻┳┻┻┻┳┳┻┳┳┻┻┻┻┳┳┳┻┳┻
┳┳┻┻┻┻┳┳┳┳┻┻┻┳┻┳┳┻┻┻┳┻┳┻┳┻┳┳┳┻┳┻
┳┳┻┳┳┳┻┳┳┳┳┻┳┳┳┻┻┳┳┳┳┻┻┳┳┳┻┳┳┳┻┳
┳┳┻┻┳┳┻┳┳┻┻┳┳┳┳┳┻┻┻┻┳┳┻┻┳┳┳┻┻┳┳┳
┻┻┻┳┳┳┻┳┻┳┳┻┻┻┳┻┻┻┻┳┻┳┻┳┳┳┻┳┻┻┳┳

~~~~



<hr>
### License

#### The MIT License (MIT)

<small>
Copyright (c) Lindsay Lawrence

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
</small>

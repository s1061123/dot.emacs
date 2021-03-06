;; mcolm�ǲ��Ԥ���
(defun add-newline (mcolm) 
  (interactive "nmaxcolumn:\n")
  (let 
      ((oldp (point))
       (curp (point-min))
       (mpoint (point-max))
       (newp 0)
       )
    (setq mcolm (+ mcolm 1))
    (while (< curp mpoint)
      (setq newp (+ curp mcolm))
      (goto-char newp)
      (insert "\n")
      (setq curp (+ curp mcolm))
      )
    ;; move to previous point
    (goto-char oldp)
    )
  )

;; This replace is only once for entire string.
;; (i.e. "test test" (s/test/xxx/) -> "xxx test"
;; if you want replace all, please use replace-str-with-expand2
(defun replace-str-with-expand (val st inc m1 m2)
  (interactive "sreplace string:\nsreplace string: %s\tbegin:\nsreplace string: %s\tbegin: %s\tinc:\nr")
  (let ((basetext (buffer-substring m1 m2))
	(counter  (string-to-number st))
	(incend   (string-to-number inc))
	(reps     "")
	(cnt 0))
    (insert "\n")
    (while (< cnt incend)
      (let ((v (number-to-string (+ counter cnt))))
	(string-match val basetext) 
	(insert (concat (replace-match v t nil basetext) "\n"))
	(setq cnt (+ cnt 1))
	))
  )
)


;; replace everytime.
(defun replace-str-with-expand2 (val st inc m1 m2)
  (interactive "sreplace string:\nsreplace string: %s\tbegin:\nsreplace string: %s\tbegin: %s\tinc:\nr")
  (let ((basetext (buffer-substring m1 m2))
	(counter  (string-to-number st))
	(incend   (string-to-number inc))
	(reps     "")
	(cnt 0))
    (insert "\n")
    (while (< cnt incend)
      (let ((v (number-to-string (+ counter cnt))))
	(string-match val basetext) 
	(let ((newtext (replace-match v t nil basetext)))
	  (while (string-match val newtext)
	    (setq newtext (replace-match v t nil newtext)))
	  (insert (concat newtext "\n")) )
	(setq cnt (+ cnt 1))
	)
      )
    )
  )


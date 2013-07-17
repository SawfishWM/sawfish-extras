;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                               ;
; yarock.jl remote for Yarock audioplayer       ;
;                                               ;
; Christopher Roy Bratusek <nano@tuxfamily.org> ;
;                                               ;
; 2012-2013 / GNU GPL v3                        ;
;                                               ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-structure yarock
  (export start-yarock
          stop-yarock
	  yarock-remote)

  (open rep
        rep.system
        rep.io.processes
        rep.io.timers
	rep.util.misc
        sawfish.wm.misc
        sawfish.wm.windows
        sawfish.wm.workspace)

  (define %yarock-proc nil)

  (define (start-yarock)
    "Start YaRock if not already running."
    (if (program-exists-p "YaRock")
        (progn
	  (when %yarock-proc (kill-process %yarock-proc))
          (setq %yarock-proc (make-process))
          (start-process %yarock-proc "YaRock"))
      (display-message (format nil "YaRock executable not found in PATH."))))

  (define (stop-yarock)
    "Stop YaRock, if running."
    (when %yarock-proc (kill-process %yarock-proc)))

  (define (yarock-remote action #!optional value)
    (case action
      ((play) (system "YaRock --play &"))
      ((play-pause) (system "YaRock --play-pause &"))
      ((pause) (system "YaRock --pause &"))
      ((stop) (system "YaRock --stop &"))
      ((prev) (system "YaRock --previous &"))
      ((next) (system "YaRock --next &"))
      ((volume) (system (format nil "YaRock --volume %s &") value))
      ((vol+) (system "YaRock --volume-up &"))
      ((vol-) (system "YaRock --voluem-down &"))
      ((seekto) (system (format nil "YaRock --seek-to %s &") value))
      ((seekby) (system (format nil "YaRock --seek-by %s &") value))
      ((append) (system (format nil "YaRock --append %s &") value))
      ((load) (system (format nil "YaRock --load %s &") value))
      ((nthtrack) (system (format nil "YaRock --play-track %s &") value))
      (t nil))))

; BeOS/theme.jl

(let*
  (
    (font (get-font "-adobe-helvetica-bold-r-normal-*-*-120-*-*-p-*-iso8859-1"))
    (font-colors (list "grey"
                       "black"))
    
    (title-width
      (lambda (w)
        (let
          ((w-width (car (window-dimensions w))))
        (max 0 (+ 20 (min (- w-width 55) (text-width (window-name w) font)))))))
          
    (update-title-width
      (lambda (w)
        (if (eq (window-get w 'current-frame-style) 'BeOS) 
          (rebuild-frame w))))
    
    (title-images (list (make-image "mid-title-inactive.png")
                        (make-image "mid-title-active.png")))
    (close-images (list (make-image "close-inactive.png") 
                        (make-image "close-active.png")))
    (maximize-images (list (make-image "maximize-inactive.png")
                           (make-image "maximize-active.png")))
    (bottom-image (make-image "bottom-bar.png"))
    (top-image (make-image "top-bar.png"))
    (top-left-image (make-image "top-left.png"))
    (top-right-image (make-image "top-right.png"))
    (bottom-left-image (make-image "bottom-left.png"))
    (bottom-right-image (make-image "bottom-right.png"))
    (left-image (make-image "left-bar.png"))
    (right-image (make-image "right-bar.png"))

    (frame `(
        ((background . ,top-image)
         (top-edge . -5)
         (left-edge . 0)
         (right-edge . 0)
         (class . title))
        ((background . ,left-image)
         (left-edge . -5)
         (top-edge . 0)
         (bottom-edge . 0)
         (class . left-border))
        ((background . ,top-left-image)
         (left-edge . -5)
         (top-edge . -5)
         (class . title))
        ((background . ,top-right-image)
         (right-edge . -5)
         (top-edge . -5)
         (class . title))
        ((background . ,right-image)
         (right-edge . -5)
         (top-edge . 0)
         (bottom-edge . 0)
         (class . right-border))
        ((background . ,bottom-image)
         (left-edge . 0)
         (right-edge . 0)
         (bottom-edge . -5)
         (class . bottom-border))
        ((background . ,bottom-left-image)
         (left-edge . -5)
         (bottom-edge . -5)
         (class . bottom-left-corner))
        ((background . ,bottom-right-image)
         (right-edge . -5)
         (bottom-edge . -5)
         (class . bottom-right-corner))
        ((background . ,title-images)
         (foreground . ,font-colors)
         (font . ,font)
         (text . ,window-name)
         (top-edge . -24)
         (left-edge . 15)
         (width . ,(lambda (w) (title-width w)))
         (x-justify . center)
         (y-justify . center)
         (class . title))
        ((background . ,close-images)
         (left-edge . -5)
         (top-edge . -24)
         (class . close-button))
        ((background . ,maximize-images)
         (left-edge . ,(lambda (w) (+ (title-width w) 15)))
         (top-edge . -24)
         (class . maximize-button))
      ))
      
    (shaped-frame `(
        ((background . ,title-images)
         (foreground . ,font-colors)
         (font . ,font)
         (text . ,window-name)
         (top-edge . -24)
         (left-edge . 15)
         (width . ,(lambda (w) (title-width w)))
         (x-justify . center)
         (y-justify . center)
         (class . title))
        ((background . ,close-images)
         (left-edge . -5)
         (top-edge . -24)
         (class . close-button))
        ((background . ,maximize-images)
         (left-edge . ,(lambda (w) (+ (title-width w) 15)))
         (top-edge . -24)
         (class . maximize-button))
      ))
      
      (transient-frame `(
        ((background . ,top-image)
         (top-edge . -5)
         (left-edge . 0)
         (right-edge . 0)
         (class . title))
        ((background . ,left-image)
         (left-edge . -5)
         (top-edge . 0)
         (bottom-edge . 0)
         (class . left-border))
        ((background . ,top-left-image)
         (left-edge . -5)
         (top-edge . -5)
         (class . title))
        ((background . ,top-right-image)
         (right-edge . -5)
         (top-edge . -5)
         (class . title))
        ((background . ,right-image)
         (right-edge . -5)
         (top-edge . 0)
         (bottom-edge . 0)
         (class . right-border))
        ((background . ,bottom-image)
         (left-edge . 0)
         (right-edge . 0)
         (bottom-edge . -5)
         (class . bottom-border))
        ((background . ,bottom-left-image)
         (left-edge . -5)
         (bottom-edge . -5)
         (class . bottom-left-corner))
        ((background . ,bottom-right-image)
         (right-edge . -5)
         (bottom-edge . -5)
         (class . bottom-right-corner))
        ((background . ,maximize-images)
         (left-edge . ,(lambda (w) (- (title-width w) 3)))
         (top-edge . -24)
         (class . title))
        ((background . ,title-images)
         (foreground . ,font-colors)
         (font . ,font)
         (text . ,window-name)
         (top-edge . -24)
         (left-edge . 15)
         (width . ,(lambda (w) (title-width w)))
         (x-justify . center)
         (y-justify . center)
         (class . title))
        ((background . ,close-images)
         (left-edge . -5)
         (top-edge . -24)
         (class . close-button))
      ))
      
    (shaped-transient-frame `(
        ((background . ,maximize-images)
         (left-edge . ,(lambda (w) (- (title-width w) 3)))
         (top-edge . -24)
         (class . title))
        ((background . ,title-images)
         (foreground . ,font-colors)
         (font . ,font)
         (text . ,window-name)
         (top-edge . -24)
         (left-edge . 15)
         (width . ,(lambda (w) (title-width w)))
         (x-justify . center)
         (y-justify . center)
         (class . title))
        ((background . ,close-images)
         (left-edge . -5)
         (top-edge . -24)
         (class . close-button))
      ))
    )

  (add-frame-style 'BeOS
    (lambda (w type)
      (case type 
        ((default) frame)
        ((transient) transient-frame)
        ((shaped-transient) shaped-transient-frame)
        ((shaped) shaped-frame))))
            
  (call-after-property-changed 'WM_NAME update-title-width)
)

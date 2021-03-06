(require 'req-package)

(req-package key-chord
  :ensure t
  :chords (("qw" . kill-this-buffer)
           ("qq" . kill-this-buffer)
           (";2" . split-window-below)
           (";3" . split-window-right)
           (";4" . kill-buffer-and-window)
           (";0" . delete-window)
           (";n" . scroll-up-command)
           (";h" . scroll-down-command)
           (";/" . undo)
           (";u" . "\C-u")
           (";j" . "\C-n")
           (";k" . "\C-p")
           (";g" . "\C-g")
           ("1e" . "\C-a")
           ("2e" . "\C-a\t")
           ("3e" . "\C-e")
           ("4e" . "\C-e "))
  :config (key-chord-mode 1))

(provide 'init-chords)

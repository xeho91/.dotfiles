# Zinit

A Zsh plugin manager.

_Official documentations:_
- https://zdharma.org/zinit/wiki/
- https://github.com/zdharma/zinit

---

## Learning notes

### Order of execution for ice modifiers

1. `atinit`
2. `atpull`
3. `make'!!'`
4. `mv`
5. `cp`
6. `make!`
7. `atclone`/`atpull`
8. `make`
9. **(plugin's script loading)**
10. `src`
11. `multisrc`
12. `atload`


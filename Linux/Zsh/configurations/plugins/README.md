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

---

### Difference between `light` and `load`

- `zinit load` -> causes reporting to be enabled – you can track what plugin
					does, view the information with zinit report {plugin-spec}
					and then also unload the plugin with `zinit unload`

- `zinit light` -> significantly faster loading without tracking and
				 reporting, by using which user resigns of the ability to
				 view the plugin report and to unload information

---

### Q: How to ensure that the completions are loaded for specific plugin/program?

A: They must start with underscore (`_`) and not have any file extension.
   If they're inside a downloaded package, then we can rename the file with
   completions using `atclone` ice modifier.

_Source: https://github.com/zdharma/zinit/issues/332#issuecomment-626268540_


# Debug a bug with Claude Code: from the error to a regression test

[Leer en español](README.md)

A prompt template for debugging with Claude Code without symptom patches, plus a real example with its regression test: `dividir_en_cuotas("100.00", 3)` ("split into installments") returns three installments that add up to 99.99 instead of 100.00.

The full flow (reproduce, hand over the evidence, hypotheses in plan mode, `DEBUG-CLAUDE` logs, red test and minimal fix, limits of `/rewind`) is in the recipe:

- English: https://ctrlia.dev/en/recetas/depurar-bug.html
- Español: https://ctrlia.dev/recetas/depurar-bug.html

## What's included

| File | What for |
| --- | --- |
| `prompt-template.en.txt` | The prompt for a bug, in English: fill in what's between `< >` |
| `plantilla-prompt.txt` | The same template in Spanish |
| `ejemplo/con-bug/cuotas.py` | The buggy code (rounds each installment with `float`) |
| `ejemplo/arreglado/cuotas.py` | The minimal fix with `Decimal`: leftover cents go to the first installment |
| `ejemplo/test_cuotas.py` | The regression test `test_regresion_bug_42_suma_exacta` |
| `ejemplo/rojo-verde.sh` | Checks that the test fails with the bug and passes with the fix |
| `antes-del-commit.sh` | Shows the diff and fails if `DEBUG-CLAUDE` logs remain |

The example code and the scripts' messages are in Spanish.

## How to use it

You need `python3` (standard library only).

```bash
git clone https://github.com/carlosp5751258-lgtm/ctrlia-depurar-bug.git
cd ctrlia-depurar-bug
./ejemplo/rojo-verde.sh
```

Expected output (abridged):

```text
== Rojo: código con bug (debe fallar) ==
AssertionError: Decimal('99.99') != Decimal('100.00')
FAILED (failures=1)
== Verde: código arreglado (debe pasar) ==
OK
Rojo → verde comprobado.
```

In your project: copy `prompt-template.en.txt`, fill it in with your bug and paste it into Claude Code. Before the commit, from your repo's root, run `antes-del-commit.sh` (or `grep -rn "DEBUG-CLAUDE" .`).

## What was tested

With Python 3.12.3 on Linux: `ejemplo/rojo-verde.sh` gives the `AssertionError` with the buggy code and `OK` with the fix; `antes-del-commit.sh` was tested in a scratch repo with and without a `DEBUG-CLAUDE` log. The recipe was written with Claude Code **2.1.316**; the Claude Code features it mentions come from the official documentation and a full interactive session with the template hasn't been recorded yet.

## License

MIT. See [LICENSE](LICENSE).

---
Part of **[Ctrl+IA](https://ctrlia.dev/)**: code with Claude Code like a pro, in Spanish. Made by Carlos P.

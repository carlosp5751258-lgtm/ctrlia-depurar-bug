# Debug a bug with Claude Code: from the error to a regression test

[Leer en español](README.md)

The Spanish version is in the repository root and in [README.md](README.md); the English files are in `en/`.

A prompt template for debugging with Claude Code without symptom patches, plus a real example with its regression test: `split_into_installments("100.00", 3)` returns three installments that add up to 99.99 instead of 100.00.

The full flow (reproduce, hand over the evidence, hypotheses in plan mode, `DEBUG-CLAUDE` logs, red test and minimal fix, limits of `/rewind`) is in the recipe:

- English: https://ctrlia.dev/en/recetas/depurar-bug.html
- Español: https://ctrlia.dev/recetas/depurar-bug.html

## What's included

| File | What for |
| --- | --- |
| `en/plantilla-prompt.txt` | The prompt for a bug, in English: fill in what's between `< >` |
| `en/ejemplo/con-bug/cuotas.py` | The buggy code (rounds each installment with `float`) |
| `en/ejemplo/arreglado/cuotas.py` | The minimal fix with `Decimal`: leftover cents go to the first installment |
| `en/ejemplo/test_cuotas.py` | The regression test `test_regression_bug_42_exact_sum` |
| `en/ejemplo/rojo-verde.sh` | Checks that the test fails with the bug and passes with the fix |
| `en/antes-del-commit.sh` | Shows the diff and fails if `DEBUG-CLAUDE` logs remain |

## How to use it

You need `python3` (standard library only).

```bash
git clone https://github.com/carlosp5751258-lgtm/ctrlia-depurar-bug.git
cd ctrlia-depurar-bug
./en/ejemplo/rojo-verde.sh
```

Expected output (abridged):

```text
== Red: buggy code (must fail) ==
AssertionError: Decimal('99.99') != Decimal('100.00')
FAILED (failures=1)
== Green: fixed code (must pass) ==
OK
Red → green confirmed.
```

In your project: copy `en/plantilla-prompt.txt`, fill it in with your bug and paste it into Claude Code. Before the commit, from your repo's root, run `/path/to/ctrlia-depurar-bug/en/antes-del-commit.sh` (or `grep -rn "DEBUG-CLAUDE" .`).

## What was tested

With Python 3.12.3 on Linux: `ejemplo/rojo-verde.sh` (and its English copy in `en/`) gives the `AssertionError` with the buggy code and `OK` with the fix; `antes-del-commit.sh` was tested in a scratch repo with and without a `DEBUG-CLAUDE` log. The recipe was written with Claude Code **2.1.316**; the Claude Code features it mentions come from the official documentation and a full interactive session with the template hasn't been recorded yet.

## License

MIT. See [LICENSE](LICENSE).

---
Part of **[Ctrl+IA](https://ctrlia.dev/)**: code with Claude Code like a pro. Made by Carlos P.

# Depurar un bug con Claude Code: del error al test de regresión

[Read in English](README.en.md)

English version: [README.en.md](README.en.md) (archivos en `en/`).

Una plantilla de prompt para depurar con Claude Code sin parches del síntoma, y un ejemplo real con su test de regresión: `dividir_en_cuotas("100.00", 3)` devuelve tres cuotas que suman 99.99 en vez de 100.00.

El flujo completo (reproducir, pasar la evidencia, hipótesis en modo plan, logs `DEBUG-CLAUDE`, test en rojo y arreglo mínimo, límites de `/rewind`) está en la receta:

- Español: https://ctrlia.dev/recetas/depurar-bug.html
- English: https://ctrlia.dev/en/recetas/depurar-bug.html

## Qué incluye

| Archivo | Para qué |
| --- | --- |
| `plantilla-prompt.txt` | El prompt para un bug, en español: rellena lo que va entre `< >` |
| `en/plantilla-prompt.txt` | La misma plantilla en inglés |
| `ejemplo/con-bug/cuotas.py` | El código con el bug (redondea cada cuota con `float`) |
| `ejemplo/arreglado/cuotas.py` | El arreglo mínimo con `Decimal`: los céntimos sobrantes van a la primera cuota |
| `ejemplo/test_cuotas.py` | El test de regresión `test_regresion_bug_42_suma_exacta` |
| `ejemplo/rojo-verde.sh` | Comprueba que el test falla con el bug y pasa con el arreglo |
| `antes-del-commit.sh` | Enseña el diff y falla si quedan logs `DEBUG-CLAUDE` |

## Cómo usarlo

Necesitas `python3` (solo biblioteca estándar).

```bash
git clone https://github.com/carlosp5751258-lgtm/ctrlia-depurar-bug.git
cd ctrlia-depurar-bug
./ejemplo/rojo-verde.sh
```

Salida esperada (resumida):

```text
== Rojo: código con bug (debe fallar) ==
AssertionError: Decimal('99.99') != Decimal('100.00')
FAILED (failures=1)
== Verde: código arreglado (debe pasar) ==
OK
Rojo → verde comprobado.
```

En tu proyecto: copia `plantilla-prompt.txt`, rellénala con tu bug y pégala en Claude Code. Antes del commit, desde la raíz de tu repo, ejecuta `antes-del-commit.sh` (o `grep -rn "DEBUG-CLAUDE" .`).

## Qué se probó

Con Python 3.12.3 en Linux: `ejemplo/rojo-verde.sh` da el `AssertionError` con el código con bug y `OK` con el arreglo; `antes-del-commit.sh` se probó en un repo de prueba con y sin un log `DEBUG-CLAUDE`. La receta se escribió con Claude Code **2.1.316**; las funciones de Claude Code que cita salen de la documentación oficial y aún no se ha grabado una sesión interactiva completa con la plantilla.

## Licencia

MIT. Ver [LICENSE](LICENSE).

---
Parte de **[Ctrl+IA](https://ctrlia.dev/)**: programa con Claude Code como un pro, en español. Hecho por Carlos P.

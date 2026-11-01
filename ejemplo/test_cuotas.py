import unittest
from decimal import Decimal

from cuotas import dividir_en_cuotas


class TestCuotas(unittest.TestCase):
    def test_regresion_bug_42_suma_exacta(self):
        # Bug #42: 100.00 en 3 cuotas sumaba 99.99
        cuotas = dividir_en_cuotas("100.00", 3)
        self.assertEqual(sum(Decimal(str(c)) for c in cuotas), Decimal("100.00"))

    def test_division_exacta_no_cambia(self):
        cuotas = dividir_en_cuotas("90.00", 3)
        self.assertEqual([Decimal(str(c)) for c in cuotas], [Decimal("30.00")] * 3)


if __name__ == "__main__":
    unittest.main()

import unittest
from decimal import Decimal

from cuotas import split_into_installments


class TestInstallments(unittest.TestCase):
    def test_regression_bug_42_exact_sum(self):
        # Bug #42: 100.00 in 3 installments added up to 99.99
        installments = split_into_installments("100.00", 3)
        self.assertEqual(sum(Decimal(str(c)) for c in installments), Decimal("100.00"))

    def test_exact_division_unchanged(self):
        installments = split_into_installments("90.00", 3)
        self.assertEqual([Decimal(str(c)) for c in installments], [Decimal("30.00")] * 3)


if __name__ == "__main__":
    unittest.main()

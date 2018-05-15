# test_specs.py
#Unit Testing
#Jaron Whittington



import specs
import pytest
import random


def test_add():
    assert specs.add(1, 3) == 4, "failed on positive integers"
    assert specs.add(-5, -7) == -12, "failed on negative integers"
    assert specs.add(-6, 14) == 8

def test_divide():
    assert specs.divide(4,2) == 2, "integer division"
    assert specs.divide(5,4) == 1.25, "float division"
    with pytest.raises(ZeroDivisionError) as excinfo:
        specs.divide(4, 0)
    assert excinfo.value.args[0] == "second input cannot be zero"


def test_smallest_factor():
    assert specs.smallest_factor(1) == 1, "failed for 1"
    assert specs.smallest_factor(24) == 2, "failed for even number"
    assert specs.smallest_factor(17) == 17, "failed for prime number"
    assert specs.smallest_factor(25) == 5, "failed for square of prime"


def test_month_length():
    assert specs.month_length("September") == 30, "failed for 30 day month"
    assert specs.month_length("January") == 31, "failed for 31 day month"
    assert specs.month_length("February") == 28, "failed for 28 day month"
    assert specs.month_length("February", True) == 29, "failed for 29 day month"
    assert specs.month_length("bad") is None, "failed for bad input"

def test_operate():
    with pytest.raises(TypeError) as excinfo:
        specs.operate(2,3,0)
    assert excinfo.value.args[0] == "oper must be a string"
    assert specs.operate(2,2,"+") == 4, "failed for addition"
    assert specs.operate(2,2,"-") == 0, "failed for subtraction"
    assert specs.operate(2,3,"*") == 6, "failed for multiplication"
    assert specs.operate(4,2,"/") == 2, "failed for division"
    with pytest.raises(ZeroDivisionError) as excinfo:
        specs.operate(4,0,"/")
    assert excinfo.value.args[0] == "division by zero is undefined"
    with pytest.raises(ValueError) as excinfo:
        specs.operate(2,2,"%")
    assert excinfo.value.args[0] == "oper must be one of '+', '/', '-', or '*'" 

@pytest.fixture
def set_up_fractions():
    frac_1_3 = specs.Fraction(1, 3)
    frac_1_2 = specs.Fraction(1, 2)
    frac_n2_3 = specs.Fraction(-2, 3)
    return frac_1_3, frac_1_2, frac_n2_3

def test_fraction_init(set_up_fractions):
    frac_1_3, frac_1_2, frac_n2_3 = set_up_fractions
    assert frac_1_3.numer == 1
    assert frac_1_2.denom == 2
    assert frac_n2_3.numer == -2
    frac = specs.Fraction(30, 42)
    assert frac.numer == 5
    assert frac.denom == 7
    with pytest.raises(ZeroDivisionError) as excinfo:
        test = specs.Fraction(5,0)
    assert excinfo.value.args[0] == "denominator cannot be zero"
    with pytest.raises(TypeError) as excinfo:
        test = specs.Fraction(2.5,2.7)
    assert excinfo.value.args[0] == "numerator and denominator must be integers"

def test_fraction_str(set_up_fractions):
    frac_1_3, frac_1_2, frac_n2_3 = set_up_fractions
    assert str(frac_1_3) == "1/3"
    assert str(frac_1_2) == "1/2"
    assert str(frac_n2_3) == "-2/3"
    frac = specs.Fraction(2,1)
    assert str(frac) == "2"

def test_fraction_float(set_up_fractions):
    frac_1_3, frac_1_2, frac_n2_3 = set_up_fractions
    assert float(frac_1_3) == 1 / 3.
    assert float(frac_1_2) == .5
    assert float(frac_n2_3) == -2 / 3.

def test_fraction_eq(set_up_fractions):
    frac_1_3, frac_1_2, frac_n2_3 = set_up_fractions
    assert frac_1_2 == specs.Fraction(1, 2)
    assert frac_1_3 == specs.Fraction(2, 6)
    assert frac_n2_3 == specs.Fraction(8, -12)
    assert frac_1_3 == 2/6

def test_fraction_add(set_up_fractions):
    frac_1_3, frac_1_2, frac_n2_3 = set_up_fractions
    assert frac_1_3 + frac_1_2 == specs.Fraction(5,6)

def test_fraction_sub(set_up_fractions):
    frac_1_3, frac_1_2, frac_n2_3 = set_up_fractions
    assert frac_1_2 - frac_1_3 == specs.Fraction(1,6)

def test_fraction_mul():
    assert specs.Fraction(1,2)*specs.Fraction(1,2) == specs.Fraction(1,4)

def test_fraction_truediv(set_up_fractions):
    frac_1_3, frac_1_2, frac_n2_3 = set_up_fractions
    assert frac_1_3 / frac_1_2 == specs.Fraction(2,3)
    with pytest.raises(ZeroDivisionError) as excinfo:
        frac_1_3 / specs.Fraction(0,2)
    assert excinfo.value.args[0] == "cannot divide by zero"




@pytest.fixture
def set_hands():
    cards = []
    for i in range(3):
        for j in range(3):
            for k in range(3):
                for l in range(3):
                    cards.append(str(i)+str(j)+str(k)+str(l))
    return cards

def test_count_sets(set_hands):
    cards = set_hands
    hand = random.sample(cards,12)
    bad = hand
    bad[1] = bad[2]
    short = random.sample(cards,11)
    bad4, badOther = short, short
    bad4.append("012")
    badOther.append("0123")
    with pytest.raises(ValueError) as excinfo:
        specs.count_sets(short)
    assert excinfo.value.args[0] == "Bad hand!"
    with pytest.raises(ValueError) as excinfo:
        specs.count_sets(bad)
    assert excinfo.value.args[0] == "Bad hand!"
    with pytest.raises(ValueError) as excinfo:
        specs.count_sets(bad4)
    assert excinfo.value.args[0] == "Bad hand!"
    with pytest.raises(ValueError) as excinfo:
        specs.count_sets(badOther)
    assert excinfo.value.args[0] == "Bad hand!"
    assert specs.count_sets(["1212","1211","2001","0222","2102","0020","0121","2202","1011","2000","0101","1202"]) == 6

        

def test_is_set(set_hands):
    cards = set_hands
    assert specs.is_set("1210","1001","1122") == True
    assert specs.is_set("1022","1122","1020") == False

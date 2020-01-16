#include "stdafx.h"
#include "C8_1.h"



Complex Complex::operator+ (const Complex &c2) const {
	return Complex(real + c2.real, imag + c2.imag);
}

Complex Complex::operator- (const Complex &c2) const {
	return Complex(real - c2.real, imag - c2.imag);
}

// (ac-bd) + (bc+ad)i 
Complex Complex::operator* (const Complex &c2) const {
	double ac = real * c2.real;
	double bd = imag * c2.imag;
	double bc = imag * c2.real;
	double ad = real * c2.imag;
	return Complex(ac-bd, bc+ad);
}

Complex Complex::operator/ (const Complex &c2) const {
	double ac = real * c2.real;
	double bd = imag * c2.imag;
	double bc = imag * c2.real;
	double ad = real * c2.imag;
	double sqr = c2.real * c2.real + c2.imag * c2.imag;
	if ((c2.real < 1e-10)&&(c2.imag <1e-10))
		return Complex(0,0);
	else
		return Complex((ac+bd)/sqr,(bc-ad)/sqr);
}

ostream & operator<< (ostream &out, const Complex &c)
{
	out << c.real << " " << c.imag << endl;
	return out;
}


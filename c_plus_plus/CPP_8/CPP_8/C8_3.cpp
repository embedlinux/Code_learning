#include "stdafx.h"
#include "C8_3.h"


/*用dynamic_cast类型转换操作符完成该函数*/
/*
	函数int getVertexCount(Shape * b)计算b的顶点数目，
	若b指向Shape类型，返回值为0；
	若b指向Triangle类型，返回值为3；
	若b指向Rectangle类型，返回值为4。
*/
int getVertexCount(Shape3 * b){
	Triangle * triangle = dynamic_cast<Triangle*>(b);
	if (triangle != nullptr)
		return 3;

	Rectangle * rectangle = dynamic_cast<Rectangle*>(b);
	if (rectangle != nullptr)
		return 4;

	return 0;

}

#include "stdafx.h"
#include "C8_3.h"


/*��dynamic_cast����ת����������ɸú���*/
/*
	����int getVertexCount(Shape * b)����b�Ķ�����Ŀ��
	��bָ��Shape���ͣ�����ֵΪ0��
	��bָ��Triangle���ͣ�����ֵΪ3��
	��bָ��Rectangle���ͣ�����ֵΪ4��
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

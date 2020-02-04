#include "stdafx.h"
#include <iostream>


/*
1 ��ĳ�о���һ���ݽ����������� 24 ���˲μӣ����μ�˳�����ò����š����������֣�ǰ����Ϊ��̭����������Ϊ������
2 ��������ʽ���������
	��һ�ַ�Ϊ 4 ��С�飬���ݲ�����˳�����λ��֣����� 100-105 Ϊһ�飬 106-111 Ϊ�ڶ��飬�������ƣ�ÿ�� 6 ���ˣ�ÿ�˷ֱ𰴲�����˳���ݽ�����С���ݽ������̭����������������ѡ�֣�Ȼ�������һ��С��ı�����
	�ڶ��ַ�Ϊ 2 ��С�飬ÿ�� 6 �ˣ�ÿ���˷ֱ𰴲�����˳���ݽ�����С�������̭����������������ѡ�֣�Ȼ�������һ��С��ı�����
	������ֻʣ�� 6 ���ˣ�����Ϊ������ѡ��ǰ������
	ѡ��ÿ��Ҫ������飬���б�����
4 ���������֣� 10 ����ί��֣�ȥ����͡���߷֣���ƽ����
ÿ��ѡ���ݽ����� 10 ����ί�ֱ��֡���ѡ�ֵ����յ÷���ȥ��һ����߷ֺ�һ����ͷ֣����ʣ�µ� 8 ���ɼ���ƽ���֡�ѡ�ֵ����ΰ��÷ֽ������У����÷�һ����������������������
�� STL ��̣����һ������
1��   ���ӡ������ѡ�ֵ�����������ţ����Բ����ŵ��������С�
2��   ��ӡÿһ�ֱ���ǰ���������
3��   ��ӡÿһ�ֱ�����С���������
4��   ��ӡ����ǰ������ѡ�����ơ��ɼ���
*/

using namespace std;

#include "string"
#include "set"
#include "iterator"
#include <vector>
#include <algorithm>
#include "functional"
#include <numeric>
#include "map"
#include "deque"

struct Speaker
{
	public:
		string m_name;
		int m_score[3];
};

int GenSpearker(map<int, Speaker> &mapSpeaker, vector<int> &v)
{
	string str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	for(int i=1;i <= 24;i++)
	{
		random_shuffle(str.begin(),str.end());
		Speaker tmp;
		tmp.m_name = "ѡ��";
		tmp.m_name = tmp.m_name + str[i];
		mapSpeaker.insert(pair<int, Speaker>(100+i, tmp));
	}

	for(int i = 1;i <= 24;i++)
	{
		v.push_back(100+i);
	}
	return 0;
}

// ��ǩ
int speech_contest_draw(vector<int> &v)
{
	random_shuffle(v.begin(),v.end());
	return 0;
}

//ѡ�ֱ���
int speech_contest(int index, vector<int> &v1, map<int, Speaker> &mapSpeaker,vector<int> &v2)
{
	//С������÷ּ�¼����,��ǰ����,������
	multimap<int, int, greater<int>> multmapGroup;		// С��ɼ�,����,���
	int tempCout = 0;
	for(vector<int>::iterator it=v1.begin();it != v1.end();it++)
	{
		tempCout++;
		// ���
		deque<int> dscore;
		for(int j = 0; j < 10;j++)
		{
			int score = 50 + rand()%50;
			dscore.push_back(score);
		}
		sort(dscore.begin(),dscore.end());
		dscore.pop_back();
		dscore.pop_front();		//ȥ����߷ֺ���ͷ�

		// ��ƽ����
		int scoresum = accumulate(dscore.begin(),dscore.end(),0);
		int scoreavg = scoresum / dscore.size();

		mapSpeaker[*it].m_score[index] = scoreavg;

		multmapGroup.insert(pair<int, int>(scoreavg, *it));

		// �������
		if(tempCout % 6 == 0)
		{
			cout << "��"<< tempCout/6<<"С������ɼ�:" << endl;
			for(multimap<int, int, greater<int>>::iterator mit = multmapGroup.begin();mit != multmapGroup.end();mit++)
			{
				// ���  ����  �÷�
				cout<<"  "<< mit->second << "\t" << mapSpeaker[mit->second].m_name << "\t"<<mit->first << endl;
			}

			// ǰ��������
			while (multmapGroup.size() > 3)
			{
				multimap<int, int, greater<int>>::iterator it1 = multmapGroup.begin();
				v2.push_back(it1->second);	// ǰ�����ŵ�v2����������
				multmapGroup.erase(it1);
			}

			multmapGroup.clear();   //��ձ�С��ɼ�

		}
	}
	return 0;
}

//�鿴���
int speech_contest_print(int index, vector<int> &v, map<int, Speaker> &mapSpeaker)
{
	cout<<"---------------------------------------------"<<endl;
	cout<<"��"<<index+1<<"�ֽ�������:"<<endl;
	for(vector<int>::iterator it = v.begin();it != v.end();it++)
	{
		cout<<"  "<<"�������:"<<*it<<"\t"<<mapSpeaker[*it].m_name<<"\t"<<mapSpeaker[*it].m_score[index]<<endl;
	}
	cout<<"---------------------------------------------"<<endl;
	return 0;
}


int main2()
{
	//���������
	map<int, Speaker> mapSpeaker;	// ����ѡ��
	vector<int>   v1;				// ��һ�ֱ���
	vector<int>   v2;
	vector<int>   v3;
	vector<int>   v4;				// ���ǰ����

	//����ѡ�� �õ���һ�ֱ�������
	GenSpearker(mapSpeaker, v1);

	//��һ��ѡ�ֳ�ǩ,����,�鿴�������
	speech_contest_draw(v1);
	speech_contest(0,v1, mapSpeaker, v2);
	speech_contest_print(0, v2, mapSpeaker);

	//�ڶ���ѡ�ֳ�ǩ,����,�鿴�������
	speech_contest_draw(v2);
	speech_contest(1,v2, mapSpeaker, v3);
	speech_contest_print(1, v3, mapSpeaker);

	//������ѡ�ֳ�ǩ,����,�鿴�������
	speech_contest_draw(v3);
	speech_contest(2,v3, mapSpeaker, v4);
	speech_contest_print(2, v4, mapSpeaker);

	system("pause");

	return 0;
}
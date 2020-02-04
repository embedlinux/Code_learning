#include "stdafx.h"
#include <iostream>


/*
1 ）某市举行一场演讲比赛，共有 24 个人参加，按参加顺序设置参赛号。比赛共三轮，前两轮为淘汰赛，第三轮为决赛。
2 ）比赛方式：分组比赛
	第一轮分为 4 个小组，根据参赛号顺序依次划分，比如 100-105 为一组， 106-111 为第二组，依次类推，每组 6 个人，每人分别按参赛号顺序演讲。当小组演讲完后，淘汰组内排名最后的三个选手，然后继续下一个小组的比赛。
	第二轮分为 2 个小组，每组 6 人，每个人分别按参赛号顺序演讲。当小组完后，淘汰组内排名最后的三个选手，然后继续下一个小组的比赛。
	第三轮只剩下 6 个人，本轮为决赛，选出前三名。
	选手每次要随机分组，进行比赛。
4 ）比赛评分： 10 个评委打分，去除最低、最高分，求平均分
每个选手演讲完由 10 个评委分别打分。该选手的最终得分是去掉一个最高分和一个最低分，求得剩下的 8 个成绩的平均分。选手的名次按得分降序排列，若得分一样，按参赛号升序排名。
用 STL 编程，求解一下问题
1）   请打印出所有选手的名字与参赛号，并以参赛号的升序排列。
2）   打印每一轮比赛前，分组情况
3）   打印每一轮比赛后，小组晋级名单
4）   打印决赛前三名，选手名称、成绩。
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
		tmp.m_name = "选手";
		tmp.m_name = tmp.m_name + str[i];
		mapSpeaker.insert(pair<int, Speaker>(100+i, tmp));
	}

	for(int i = 1;i <= 24;i++)
	{
		v.push_back(100+i);
	}
	return 0;
}

// 抽签
int speech_contest_draw(vector<int> &v)
{
	random_shuffle(v.begin(),v.end());
	return 0;
}

//选手比赛
int speech_contest(int index, vector<int> &v1, map<int, Speaker> &mapSpeaker,vector<int> &v2)
{
	//小组比赛得分记录下来,求前三名,后三名
	multimap<int, int, greater<int>> multmapGroup;		// 小组成绩,分数,编号
	int tempCout = 0;
	for(vector<int>::iterator it=v1.begin();it != v1.end();it++)
	{
		tempCout++;
		// 打分
		deque<int> dscore;
		for(int j = 0; j < 10;j++)
		{
			int score = 50 + rand()%50;
			dscore.push_back(score);
		}
		sort(dscore.begin(),dscore.end());
		dscore.pop_back();
		dscore.pop_front();		//去掉最高分和最低分

		// 求平均分
		int scoresum = accumulate(dscore.begin(),dscore.end(),0);
		int scoreavg = scoresum / dscore.size();

		mapSpeaker[*it].m_score[index] = scoreavg;

		multmapGroup.insert(pair<int, int>(scoreavg, *it));

		// 处理分组
		if(tempCout % 6 == 0)
		{
			cout << "第"<< tempCout/6<<"小组比赛成绩:" << endl;
			for(multimap<int, int, greater<int>>::iterator mit = multmapGroup.begin();mit != multmapGroup.end();mit++)
			{
				// 编号  姓名  得分
				cout<<"  "<< mit->second << "\t" << mapSpeaker[mit->second].m_name << "\t"<<mit->first << endl;
			}

			// 前三名晋级
			while (multmapGroup.size() > 3)
			{
				multimap<int, int, greater<int>>::iterator it1 = multmapGroup.begin();
				v2.push_back(it1->second);	// 前三名放到v2晋级名单中
				multmapGroup.erase(it1);
			}

			multmapGroup.clear();   //清空本小组成绩

		}
	}
	return 0;
}

//查看结果
int speech_contest_print(int index, vector<int> &v, map<int, Speaker> &mapSpeaker)
{
	cout<<"---------------------------------------------"<<endl;
	cout<<"第"<<index+1<<"轮晋级名单:"<<endl;
	for(vector<int>::iterator it = v.begin();it != v.end();it++)
	{
		cout<<"  "<<"参赛编号:"<<*it<<"\t"<<mapSpeaker[*it].m_name<<"\t"<<mapSpeaker[*it].m_score[index]<<endl;
	}
	cout<<"---------------------------------------------"<<endl;
	return 0;
}


int main2()
{
	//容器的设计
	map<int, Speaker> mapSpeaker;	// 参赛选手
	vector<int>   v1;				// 第一轮比赛
	vector<int>   v2;
	vector<int>   v3;
	vector<int>   v4;				// 最后前三名

	//产生选手 得到第一轮比赛名单
	GenSpearker(mapSpeaker, v1);

	//第一轮选手抽签,比赛,查看比赛结果
	speech_contest_draw(v1);
	speech_contest(0,v1, mapSpeaker, v2);
	speech_contest_print(0, v2, mapSpeaker);

	//第二轮选手抽签,比赛,查看比赛结果
	speech_contest_draw(v2);
	speech_contest(1,v2, mapSpeaker, v3);
	speech_contest_print(1, v3, mapSpeaker);

	//第三轮选手抽签,比赛,查看比赛结果
	speech_contest_draw(v3);
	speech_contest(2,v3, mapSpeaker, v4);
	speech_contest_print(2, v4, mapSpeaker);

	system("pause");

	return 0;
}
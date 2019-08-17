#ifndef _GRAPH_H
#define _GRAPH_H

typedef void Graph;
typedef void Vertex;


Graph* Graph_Create(int n);

void Graph_Destroy(Graph* graph);

void Graph_Clear(Graph* graph);

int Graph_AddEdge(Graph* graph, int v1, int v2, int w);

int Graph_RemoveEdge(Graph* graph, int v1, int v2);

int Graph_GetEdge(Graph* graph, int v1, int v2);

int Graph_TD(Graph* graph, int v);

int Graph_VertexCount(Graph* graph);

int Graph_EdgeCount(Graph* graph);

#endif 
 

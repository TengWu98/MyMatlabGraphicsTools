/*---
function [vertex_segids] = his_clus(graph, vertex_area, paras)
Input: 

Output

--*/

#include "mex.h"
#include "hierarchical_clustering.h"
#include <vector>
using namespace std;

void mexFunction(
     int nargout,
     mxArray *output[],
     int nargin,
     const mxArray *input[]) {
  /* check argument */
  if (nargin != 3) {
    mexErrMsgTxt("Two input arguments required.");
  }
  if (nargout != 1) {
    mexErrMsgTxt("Incorrect number of output arguments."); 
  }
  
  if (static_cast<int> (mxGetM(input[0])) != 3) {
    mexErrMsgTxt("Incorrect input."); 
  }
  if (static_cast<int> (mxGetM(input[1])) != 1) {
    mexErrMsgTxt("Incorrect input."); 
  }
  if (static_cast<int> (mxGetM(input[2])) != 1) {
    mexErrMsgTxt("Incorrect input."); 
  }
  int num_edges = static_cast<int> (mxGetN(input[0]));
  double *graph_data = (double*)mxGetData(input[0]);
  vector<int> sv_ids, tv_ids;
  sv_ids.resize(num_edges);
  tv_ids.resize(num_edges);
  vector<double> edge_weights;
  edge_weights.resize(num_edges);
  for (int e_id = 0; e_id < num_edges; ++e_id) {
      sv_ids[e_id] = static_cast<int> (graph_data[3*e_id]-1);
      tv_ids[e_id] = static_cast<int> (graph_data[3*e_id+1]-1);
      edge_weights[e_id] = graph_data[3*e_id+2];
  }
  
  int num_vertices = static_cast<int> (mxGetN(input[1]));
  double *vertex_data = (double*)mxGetData(input[1]);
  vector<double> vertex_area;
  vertex_area.resize(num_vertices);
  for (int v_id = 0; v_id < num_vertices; ++v_id) {
      vertex_area[v_id] = vertex_data[v_id];
  }
  
  double *para_data = (double*)mxGetData(input[2]);
  int num_segments = static_cast<int> (para_data[0]);
  double area_ratio = para_data[1];
  
  vector<int> vertex_segids;
  HierarchicalClustering hie_clus;
  hie_clus.Compute(sv_ids, tv_ids, edge_weights, vertex_area,
          num_segments, area_ratio,
          &vertex_segids);
  
  output[0] = mxCreateDoubleMatrix(1, num_vertices, mxREAL);
  double *output_data = mxGetPr(output[0]);
  for (int v_id = 0; v_id < num_vertices; ++v_id) {
      output_data[v_id] = vertex_segids[v_id]+1;
  }
}



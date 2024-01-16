#include "hierarchical_clustering_new.h"
#include <set>
#include <queue>
#include <cmath>

void HierarchicalClustering::Compute(
  const vector<int> &sv_ids,
  const vector<int> &tv_ids,
  const vector<double> &edge_weights,
  const vector<bool> &active_vids,
  const vector<int> &v_patchids,  
  const int &num_segments,  // ����patch�ĸ���    
  vector<int> *vertex_segmentids) { // �������vertex_segmentids��
  int num_vertices = static_cast<int> (active_vids.size()); // ����Ľ����
  int num_active_vertices = 0;// ������active�Ľ����
  for (int i=0; i<num_vertices;i++)
  {
	  if(active_vids[i])
	  {
		  num_active_vertices ++ ;
	  }
  }
  vector<GraphSegment> segments; // �洢�м�������Ҫ����num_active_vertices��
  segments.resize(2*num_active_vertices + num_segments); // �����num_active_verticesλ�ô洢�м����
  for (int i=0, active_id=0; i<num_vertices;i++) { // ��graph�е���Ϣ����segments����ʼÿ��active��㶼��һ��class,ͬ����һ��patch��inactive�����һ��class
	if(active_vids[i]) // ����active�Ľ�㣬������Ϊһ��class
	{
		segments[active_id].is_active = true;
		segments[active_id].vertex_ids.push_back(i);
		active_id++;
	}
    else // ����inactive�Ľ�㣬������patchΪһ��class
	{
		int seg_id = v_patchids[i] + num_active_vertices - 1;
		segments[seg_id].is_active = true;
		segments[seg_id].vertex_ids.push_back(i);
	}
  }

  printf("Initial done!!!\n");
  
  priority_queue<CutCost> sorted_edges; // ��ÿ����class�ı߰���cutcost����priority_queue
  // ��ʼ����£�active�����Ȩ�ؾ���edge_weight����inactive��active�����edge_weight����Ϊ���active
  // �����inactive�������patch��cutcost������inactive���֮���б����������ͬһ��patch
  
  // ����graph��ÿһ���ߣ���segment�м�¼��Ӧ�ߵ�cutcost���������ߵ�Ȩ�� 
  int num_edge = sv_ids.size();
  for (int edge_id = 0; edge_id < num_edge; ++edge_id)
  {
      int sv_id = sv_ids[edge_id];
      int tv_id = tv_ids[edge_id];
	  if(sv_id  >= num_vertices || tv_id >= num_vertices)
	  {
		  printf("sv_id or tv_id error!");
	  }
      
      // ����ʼgraph��ÿ���ߵ�cutcost����sorted_edge
      if(active_vids[sv_id] && active_vids[tv_id])
      {
          SegmentEdge se;
          se.target_segment_id = tv_id;
          se.cut_cost = edge_weights[edge_id];
          segments[sv_id].segment_edges.push_back(se);
          
          if(sv_id < tv_id)
          {
              CutCost cc;                      
              cc.seg1_id = sv_id;              
              cc.seg2_id = tv_ids[edge_id];     
              cc.ncut_cost = edge_weights[edge_id];
              sorted_edges.push(cc);
          }          
      }
      else if (!active_vids[sv_id] && !active_vids[tv_id])
      {
          //assert(v_patchids[sv_ids[edge_id]] == v_patchids[tv_ids[edge_id]]);
          if (v_patchids[sv_id] != v_patchids[tv_id])
          {
            printf("hierarchical clustering error!!! %d  %d   %d ",edge_id, sv_ids[edge_id], tv_ids[edge_id]);
            return;
          }
      }
      else if(!active_vids[sv_id])
      {
		  if(v_patchids[sv_id] > num_segments)
		  {
			  printf("v_patchids error!!!\n");
		  }
          SegmentEdge se;
          se.target_segment_id = tv_id;
          se.cut_cost = edge_weights[edge_id];
          segments[v_patchids[sv_id] + num_active_vertices - 1].segment_edges.push_back(se);
          
          if(sv_id < tv_id)
          {
              CutCost cc;           
              cc.seg1_id = tv_id;              
              cc.seg2_id = v_patchids[sv_id] + num_active_vertices - 1;
			  cc.ncut_cost = edge_weights[edge_id];
              sorted_edges.push(cc);
          }          
      }
      else if(!active_vids[tv_id])
      {
		  if(v_patchids[tv_id] > num_segments)
		  {
			  printf("v_patchids error!!!\n");
		  }
          SegmentEdge se;
          se.target_segment_id = v_patchids[tv_id] + num_active_vertices - 1;
          se.cut_cost = edge_weights[edge_id];
          segments[sv_id].segment_edges.push_back(se);
          
          if(sv_id < tv_id)
          {
              CutCost cc;           
              cc.seg1_id = sv_id;              
              cc.seg2_id = v_patchids[tv_id] + num_active_vertices - 1;
			  cc.ncut_cost = edge_weights[edge_id];
              sorted_edges.push(cc);
          }   
      }
  }

  printf("init segment done!\n");
  
  //// ����num_active_vertices�Σ�����ʼ��num_active_vertices+num_segments��class��Ҫ�����ʣnum_segments��
  //// class��ÿ�ε����ϲ���һ��class
  //for (int iter  = 0; iter < num_active_vertices; ++iter) {
  //  CutCost top_se; // ѡ��sorted_edge��cost��С��edge��������������㶼��active��
  //  do {            // ���������������һ���Ѿ���inactive��cost��С�ı�ȫ��sorted_edge��pop��
  //    top_se = sorted_edges.top(); // ���Ϊinactive�Ľ��˵���Ѿ��ϲ�������node����
  //    sorted_edges.pop();
  //  } while (!segments[top_se.seg1_id].is_active
  //    || !segments[top_se.seg2_id].is_active);

  //  
  //  // Two old segments to be merged�� ��cost��С���������ϲ�
  //  GraphSegment &segment1 = segments[top_se.seg1_id];
  //  GraphSegment &segment2 = segments[top_se.seg2_id];

  //  // Place to store the new segment���洢�ϲ���Ľ��
  //  // ��Ҫ����num_vertices - num_segments�Σ� ÿ�ε�������segment��graph��Ϣ���
  //  // �������Ϊԭ���ĵ�����ͣ����Ϊactive
  //  int new_segment_id = num_active_vertices + num_segments + iter; 
  //  GraphSegment &new_segment = segments[new_segment_id];
  //  new_segment.is_active = true;
  //  
  //  // vertices contained in this new segment
  //  // ���ϲ�ǰ����class��ĵ�ȫ�������Ե�class��
  //  new_segment.vertex_ids = segment1.vertex_ids;
  //  for (unsigned i = 0; i < segment2.vertex_ids.size(); ++i) {
  //    new_segment.vertex_ids.push_back(segment2.vertex_ids[i]);
  //  }

  //  // neighboring segments of this new segment
  //  // ��������µ�class������class��Ϣ�����ϲ�ǰ����class��������Ϣ����
  //  set<int> neigh_segmentids;
  //  for (unsigned i = 0; i < segment1.segment_edges.size(); ++i) {
  //    int id = segment1.segment_edges[i].target_segment_id;
  //    if (id != top_se.seg2_id)
  //      neigh_segmentids.insert(id);
  //  }
  //  for (unsigned i = 0; i < segment2.segment_edges.size(); ++i) {
  //    int id = segment2.segment_edges[i].target_segment_id;
  //    if (id != top_se.seg1_id)
  //      neigh_segmentids.insert(id);
  //  }

  //  // Update edges
  //  // ����active������class���µ�class�ıߵ�Ȩ����Ϣ
  //  for (set<int>::iterator iter_int = neigh_segmentids.begin();
  //    iter_int != neigh_segmentids.end();
  //    ++iter_int) {
  //    GraphSegment &neigh_segment = segments[*iter_int];
  //    vector<SegmentEdge> old_edges = neigh_segment.segment_edges; // ֮ǰ��neigh_segment���ڵ�class
  //    neigh_segment.segment_edges.clear();

  //    SegmentEdge new_edge; // �½�neigh_segment��new_segment��ı�
  //    new_edge.target_segment_id = new_segment_id;
  //    new_edge.cut_cost = 0.0;
  //    for (unsigned j = 0; j < old_edges.size(); ++j) {
  //      if (old_edges[j].target_segment_id == top_se.seg1_id) {
  //        new_edge.cut_cost += old_edges[j].cut_cost;
		//  new_edge.cut_cost /= 2;
  //      } else if (old_edges[j].target_segment_id == top_se.seg2_id) {
  //        new_edge.cut_cost += old_edges[j].cut_cost;
		//  new_edge.cut_cost /= 2;
  //      } else { // ��neigh_segmentԭ�ȵ�����class���Ǻϲ��������е�һ�����߱���������ӵ��µı�
  //        neigh_segment.segment_edges.push_back(old_edges[j]);
  //      }
  //    }
  //    neigh_segment.segment_edges.push_back(new_edge);

  //    // ͬ�����������µı߼��뵽new_segment��segment_edges��ȥ
  //    new_edge.target_segment_id = *iter_int;
  //    new_segment.segment_edges.push_back(new_edge);

  //    // Update the queue����new_edge���뵽sorted_edges��
  //    CutCost new_cut;
  //    new_cut.seg1_id = *iter_int;
  //    new_cut.seg2_id = new_segment_id;
  //    new_cut.ncut_cost = new_edge.cut_cost;

  //    sorted_edges.push(new_cut);
  //  }

  //  // Update the tide up�����Ѿ��ϲ���segment���Ϊinactive
  //  segment1.is_active = false;
  //  segment2.is_active = false;
  //  segment1.segment_edges.clear();
  //  segment1.vertex_ids.clear();
  //  segment2.segment_edges.clear();
  //  segment2.vertex_ids.clear();
  //}

  // ���Ľ���洢�ڱ��Ϊactive��segment��
  vertex_segmentids->resize(active_vids.size());
  int patch_id = 1;
  for (unsigned i = 0; i < segments.size(); ++i) {
    if (segments[i].is_active) {
      GraphSegment &segment = segments[i];
      for (unsigned j = 0; j < segment.vertex_ids.size(); ++j) {
        (*vertex_segmentids)[segment.vertex_ids[j]] = patch_id;
      }
      printf("patch_id = %d, patch_size = %d.\n",
        patch_id, static_cast<int> (segment.vertex_ids.size()));
      patch_id++;
    }
  }
}
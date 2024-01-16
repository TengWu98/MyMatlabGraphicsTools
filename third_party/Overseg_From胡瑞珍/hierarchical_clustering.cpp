#include "hierarchical_clustering.h"
#include <set>
#include <queue>
#include <cmath>

void HierarchicalClustering::Compute(
  const vector<int> &sv_ids,
  const vector<int> &tv_ids,
  const vector<double> &edge_weights,
  const vector<double> &vertex_area,
  const int &num_segments,
  const double &area_ratio,
  vector<int> *vertex_segmentids) { // �������vertex_segmentids��
  int num_vertices = static_cast<int> (vertex_area.size()); // ����Ľ����
  vector<GraphSegment> segments; // �洢�м�������Ҫ����num_vertices - num_segments��
  segments.resize(2*num_vertices - num_segments); // �����num_vertices - num_segmentsλ�ô洢�м����
  for (int seg_id = 0; seg_id < num_vertices; ++seg_id) { // ��graph�е���Ϣ����segments����ʼÿ����㶼��һ��class
    segments[seg_id].is_active = true;
    segments[seg_id].seg_area = vertex_area[seg_id];
    segments[seg_id].vertex_ids.push_back(seg_id);
  }

  priority_queue<CutCost> sorted_edges; // ��ÿ����class�ı߰���cutcost����priority_queue

  // ����graph��ÿһ���ߣ���segment�м�¼��Ӧ�ߵ�cutcost���������ߵ�Ȩ�� 
  for (int edge_id = 0; edge_id < static_cast<int> (sv_ids.size()); ++edge_id) {
    int sv_id = sv_ids[edge_id];
    SegmentEdge se;
    se.target_segment_id = tv_ids[edge_id];
    se.cut_cost = edge_weights[edge_id];
    segments[sv_id].segment_edges.push_back(se);
    if (sv_ids[edge_id] < tv_ids[edge_id]) { // ����ʼgraph��ÿ���ߵ�cutcost����sorted_edge
      CutCost cc;                       // ����costΪ�����ߵ�Ȩ�طֱ����������������ļӺ�
      cc.seg1_id = sv_id;               // ѡ��ĺϲ��Ķ��󲻽���ߵ�Ȩ���йأ�����������й�
      cc.seg2_id = tv_ids[edge_id];     // ���������ϴ�costӦ�ý�С
      cc.ncut_cost = edge_weights[edge_id]/pow(vertex_area[cc.seg1_id], area_ratio)
      + edge_weights[edge_id]/pow(vertex_area[cc.seg2_id], area_ratio);
      sorted_edges.push(cc);
    }
  }
  
  // ����num_vertices - num_segments�Σ�����ʼ��num_vertices��class��Ҫ�����ʣnum_segments��
  // class��ÿ�ε����ϲ���һ��class
  for (int iter  = 0; iter < num_vertices - num_segments; ++iter) {
    CutCost top_se; // ѡ��sorted_edge��cost��С��edge��������������㶼��active��
    do {            // ���������������һ���Ѿ���inactive��cost��С�ı�ȫ��sorted_edge��pop��
      top_se = sorted_edges.top(); // ���Ϊinactive�Ľ��˵���Ѿ��ϲ�������node����
      sorted_edges.pop();
    } while (!segments[top_se.seg1_id].is_active
      || !segments[top_se.seg2_id].is_active);

    
    // Two old segments to be merged�� ��cost��С���������ϲ�
    GraphSegment &segment1 = segments[top_se.seg1_id];
    GraphSegment &segment2 = segments[top_se.seg2_id];

    // Place to store the new segment���洢�ϲ���Ľ��
    // ��Ҫ����num_vertices - num_segments�Σ� ÿ�ε�������segment��graph��Ϣ���
    // �������Ϊԭ���ĵ�����ͣ����Ϊactive
    int new_segment_id = num_vertices + iter; 
    GraphSegment &new_segment = segments[new_segment_id];
    new_segment.is_active = true;
    new_segment.seg_area = segment1.seg_area + segment2.seg_area;

    // vertices contained in this new segment
    // ���ϲ�ǰ����class��ĵ�ȫ�������Ե�class��
    new_segment.vertex_ids = segment1.vertex_ids;
    for (unsigned i = 0; i < segment2.vertex_ids.size(); ++i) {
      new_segment.vertex_ids.push_back(segment2.vertex_ids[i]);
    }

    // neighboring segments of this new segment
    // ��������µ�class������class��Ϣ�����ϲ�ǰ����class��������Ϣ����
    set<int> neigh_segmentids;
    for (unsigned i = 0; i < segment1.segment_edges.size(); ++i) {
      int id = segment1.segment_edges[i].target_segment_id;
      if (id != top_se.seg2_id)
        neigh_segmentids.insert(id);
    }
    for (unsigned i = 0; i < segment2.segment_edges.size(); ++i) {
      int id = segment2.segment_edges[i].target_segment_id;
      if (id != top_se.seg1_id)
        neigh_segmentids.insert(id);
    }

    // Update edges
    // ����active������class���µ�class�ıߵ�Ȩ����Ϣ
    for (set<int>::iterator iter_int = neigh_segmentids.begin();
      iter_int != neigh_segmentids.end();
      ++iter_int) {
      GraphSegment &neigh_segment = segments[*iter_int];
      vector<SegmentEdge> old_edges = neigh_segment.segment_edges; // ֮ǰ��neigh_segment���ڵ�class
      neigh_segment.segment_edges.clear();

      SegmentEdge new_edge; // �½�neigh_segment��new_segment��ı�
      new_edge.target_segment_id = new_segment_id;
      new_edge.cut_cost = 0.0;
      for (unsigned j = 0; j < old_edges.size(); ++j) {
        if (old_edges[j].target_segment_id == top_se.seg1_id) {
          new_edge.cut_cost += old_edges[j].cut_cost;
        } else if (old_edges[j].target_segment_id == top_se.seg2_id) {
          new_edge.cut_cost += old_edges[j].cut_cost;
        } else { // ��neigh_segmentԭ�ȵ�����class���Ǻϲ��������е�һ�����߱���������ӵ��µı�
          neigh_segment.segment_edges.push_back(old_edges[j]);
        }
      }
      neigh_segment.segment_edges.push_back(new_edge);

      // ͬ�����������µı߼��뵽new_segment��segment_edges��ȥ
      new_edge.target_segment_id = *iter_int;
      new_segment.segment_edges.push_back(new_edge);

      // Update the queue����new_edge���뵽sorted_edges��
      CutCost new_cut;
      new_cut.seg1_id = *iter_int;
      new_cut.seg2_id = new_segment_id;
      new_cut.ncut_cost = new_edge.cut_cost/pow(neigh_segment.seg_area, area_ratio)
        + new_edge.cut_cost/pow(new_segment.seg_area, area_ratio);

      sorted_edges.push(new_cut);
    }

    // Update the tide up�����Ѿ��ϲ���segment���Ϊinactive
    segment1.is_active = false;
    segment2.is_active = false;
    segment1.segment_edges.clear();
    segment1.vertex_ids.clear();
    segment2.segment_edges.clear();
    segment2.vertex_ids.clear();
  }

  // ���Ľ���洢�ڱ��Ϊactive��segment��
  vertex_segmentids->resize(num_vertices);
  int patch_id = 0;
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
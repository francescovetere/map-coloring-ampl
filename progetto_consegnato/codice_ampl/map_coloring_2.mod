# Insieme di nodi
set NODES;

# Insieme di archi (un arco e' individuato da una coppia di nodi)
set EDGES within (NODES cross NODES);

# Insieme di colori (cardinalita' sufficientemente elevata per trovare una soluzione ammissibile)
set COLORS;

# node_color[n, c] = 1 se il nodo n e' assegnato al colore c, 0 altrimenti
var node_color {NODES, COLORS} binary; 

# color_used[c] = 1 se il colore c e' utilizzato, 0 altrimenti
var color_used {COLORS} binary;

# node_deleted[n] = 1 se il nodo n e' stato eliminato, 0 altrimenti
var node_deleted {NODES} binary;

# vincolo che impone l'assegnamento di un solo colore per ogni nodo
# (viene generato un vincolo per ogni elemento di NODES)
subject to one_color_per_node {n in NODES}: 
	sum {c in COLORS} node_color[n, c] = 1 - node_deleted[n];

# vincolo che impone l'assegnamento di colori diversi per due nodi adiacenti
# (viene generato un vincolo per ogni elemento dell'insieme formato dal prodotto cartesiano di EDGE e COLOR)
subject to different_color_adjacent {(i,j) in EDGES, c in COLORS}: 
	node_color[i, c] + node_color[j, c] <= color_used[c];

# L'obiettivo e' minimizzare i nodi eliminati 
minimize min_deleted: 
	sum{n in NODES} node_deleted[n];

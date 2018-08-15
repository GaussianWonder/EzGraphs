class GrafLectie extends ObjGraf{
	PVector addPos;
	ArrayList<IntList> graf;
	boolean oriented = true;
	ArrayList<NodeLectie> nodes;
	boolean nodeOnPossesion = false;
	int nodeOnPossesionIndex = -1, nodePrime = -1, nodeNeighbor = -1;
	ArrayList<EdgeLectie> edges;

	GrafLectie(PVector pos, color c, float w, float h, float anim){
		super(pos, c, w, h, anim);
		addPos = new PVector(0, 0);
		
		graf = new ArrayList<IntList>();
		graf.add(new IntList());	//Empty (starting with 1);
		nodes = new ArrayList<NodeLectie>();
		edges = new ArrayList<EdgeLectie>();
	}

	void display(){
		for(EdgeLectie edge : edges){
			if(!oriented) edge.displayUnoriented();
			else edge.displayOriented();
		}
		for(NodeLectie node : nodes){
			node.display();
		}
	}

	void update(){

		animate();

		int i = 0;

		for(NodeLectie node : nodes)
			node.update();

		for(EdgeLectie edge : edges)
			edge.update();
	}

	void mouseDrag(){
		for(NodeLectie node : nodes){
			if(node.active && node.isHovered(mouseX, mouseY) && mouseX>=width/2 + node.baseW + 10 && mouseX<=width - node.baseW - 10 && mouseY>=2*R + node.baseW + 10){
				node.basePos = new PVector(mouseX, mouseY);
				node.seekPosition(new PVector(mouseX, mouseY));
				break;
			}
		}
	}

	int findMissingNode(){
		boolean[] f = new boolean[30];
		for(int i=0;i<30;i++)
			f[i] = false;

		for(NodeLectie n : nodes)
			if(n.active)
				f[n.index] = true;

		for(int i=0;i<30;i++)		//return the first one missing
			if(!f[i])
				return i;

		return nodes.size() + 1;	//if none is missing add number
	}

	void joinNodes(int n, int v){
		NodeLectie nod = nodes.get(n), vec = nodes.get(v);
		int nodIndex = nod.index + 1, vecIndex = vec.index + 1;

		for(EdgeLectie edge : edges)
			if(edge.exist(nod.index, vec.index))
				return;
		
		//No repeating edge
		if(oriented){
			graf.get(nodIndex).append(vecIndex);
			edges.add(new EdgeLectie(nod, vec, n, v, color(7, 157, 243), color(0, 255, 252)));
		}
		else{
			graf.get(nodIndex).append(vecIndex);
			edges.add(new EdgeLectie(nod, vec, n, v, color(7, 157, 243), color(0, 255, 252)));
			graf.get(vecIndex).append(nodIndex);
		}

		nodePrime = nodeNeighbor = -1;
	}

	void removeFromGraf(int nod, int vec){
		for(int i=0; i<graf.get(nod).size();i++){
			int inf = graf.get(nod).get(i);
			if(inf == vec){
				graf.get(nod).remove(i);
				return;
			}
		}
	}

	void deleteEdge(int nod, int vec){
		for(int i = edges.size() - 1; i>=0;i--)
			if(edges.get(i).exist(nod, vec))
				edges.remove(i);
	}
}

int ramasNr;
void textToGraf(String ss) {
	//PVector pos, color c, float w, float h, float anim
	grafLectie = new GrafLectie(new PVector(width/2, 2*R), color(c3), midW, height, 0.2);		//init
	String[] s = to_lines(ss);
	int or=to_nr(s[0]);
	grafLectie.oriented = (or==1) ? true : false;											//oriented

	int n=to_nr(s[1]); //nr noduri
	for(int num=0;num<=n;num++)																//init IntLists() graf
		grafLectie.graf.add(new IntList());
	int nodx, nody;
	int active;
	int index;
	int i;

	for (i=2;i<=n+1;i++) {
		ramasNr=0;
		nodx=to_nr2(s[i]); //val x
		ramasNr++;
		nody=to_nr2(s[i]); //val y
		ramasNr++;
		active=to_nr2(s[i]); //activ 1 / inactiv 0
		ramasNr++;
		index=to_nr2(s[i]); //index

		//PVector pos, color c, float w, float h, float anim, int i, color hov 				//NODES
		grafLectie.nodes.add(new NodeLectie(new PVector(nodx , nody), color(255), R, R, 0.2, index, color(42)));
		grafLectie.nodes.get(grafLectie.nodes.size() - 1).active = (active==1) ? true : false;
	}

	int capat1,capat2;
	int m=to_nr(s[n+2]);

	for (i=n+3;i<=n+3+m-1;i++) {
		ramasNr=0;
		capat1=to_nr2(s[i]); //primul nod
		ramasNr++;
		capat2=to_nr2(s[i]); //al doilea nod

		NodeLectie nod = grafLectie.nodes.get(capat1), vec = grafLectie.nodes.get(capat2);
		if(or==1){
			grafLectie.graf.get(nod.index + 1).append(vec.index + 1);
		}
		else{
			grafLectie.graf.get(nod.index + 1).append(vec.index + 1);
			grafLectie.graf.get(vec.index + 1).append(nod.index + 1);
		}
		
		//NodeLectie nod, NodeLectie vec, int _n, int _v, color norm, color hov 			//EDGES + GRAF
		grafLectie.edges.add(new EdgeLectie(nod, vec, capat1, capat2, color(255), color(42)));
	}

}

int nrLines(String s) {
	int i,n=0;
	for (i=0;i<s.length();i++)
		if (s.charAt(i)=='\n')
			n++;
	return n;
}

String[] to_lines(String ss) {
	String[] s=new String[nrLines(ss)];
	int n=0,i,m=0;
	for (i=0;i<ss.length();i++)
		if (ss.charAt(i)=='\n') {
			n++;
		}
		else if (s[n]==null)
			s[n]=str(ss.charAt(i));
		else s[n]+=ss.charAt(i);
	return s;
}

int to_nr2(String s) {
	int nr=0,i;
	for (i=ramasNr;i<s.length() && s.charAt(i)!=' ';i++)
		nr=nr*10+int(s.charAt(i))-'0';
	ramasNr=i;
	return nr;
}
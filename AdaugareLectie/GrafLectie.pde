class GrafLectie extends Obj{
	PVector addPos;
	int indexBtn = -1;
	ArrayList<ToggleBtn> btns;

	ArrayList<IntList> graf;
	boolean oriented = true;
	ArrayList<NodeLectie> nodes;
	boolean nodeOnPossesion = false;
	int nodeOnPossesionIndex = -1, nodePrime = -1, nodeNeighbor = -1;
	ArrayList<EdgeLectie> edges;

	GrafLectie(PVector pos, color c, float w, float h, float anim){
		super(pos, c, w, h, anim);
		addPos = new PVector(0, 0);

		btns = new ArrayList<ToggleBtn>();
		btns.add(new ToggleBtn(new PVector(addPos.x + basePos.x, addPos.y + basePos.y), color(51,133,198), w/6, h/7, 0.2, color(66,121,163), color(14,154,167), "Adauga nod", 1));
		btns.add(new ToggleBtn(new PVector(addPos.x + basePos.x + w/6, addPos.y + basePos.y), color(51,133,198), w/6, h/7, 0.2, color(66,121,163), color(14,154,167), "Misca", 2));
		btns.add(new ToggleBtn(new PVector(addPos.x + basePos.x + 2 * w/6, addPos.y + basePos.y), color(51,133,198), w/6, h/7, 0.2, color(66,121,163), color(14,154,167), "Sterge graf", 3));
		btns.add(new ToggleBtn(new PVector(addPos.x + basePos.x + 3 * w/6, addPos.y + basePos.y), color(51,133,198), w/6, h/7, 0.2, color(66,121,163), color(14,154,167), "Adauga muchie", 4));
		btns.add(new ToggleBtn(new PVector(addPos.x + basePos.x + 4 * w/6, addPos.y + basePos.y), color(51,133,198), w/6, h/7, 0.2, color(66,121,163), color(14,154,167), "Sterge muchie", 5));
		btns.add(new ToggleBtn(new PVector(addPos.x + basePos.x + 4 * w/6, addPos.y + basePos.y), color(51,133,198), w/6, h/7, 0.2, color(66,121,163), color(14,154,167), "Sterge nod", 6));
		
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
		for(ToggleBtn btn : btns){
			btn.display();
		}
		for(NodeLectie node : nodes){
			node.display();
		}
	}

	void update(){
		animate();

		int i = 0;
		for(ToggleBtn btn : btns){
			btn.seekPosition(new PVector(addPos.x + basePos.x + i * baseW/6, addPos.y + basePos.y));
			btn.update();
			i++;
		}

		for(NodeLectie node : nodes){
			node.addPos = new PVector(addPos.x + basePos.x - 10, addPos.y + basePos.y);
			node.update();
		}

		for(EdgeLectie edge : edges){
			edge.update();
		}
	}

	void mouseEvents(){
		for(ToggleBtn btn : btns)
			if(btn.isHovered(mouseX, mouseY)){
				btn.toggle = (btn.toggle) ? false : true;
				indexBtn = (btn.toggle) ? btn.index : -1;
			}
		for(ToggleBtn btn : btns)
			if(btn.index!=indexBtn)
				btn.toggle = false;

		switch (indexBtn) {
			case 1:{		//Add/Connect
				if(mouseButton==LEFT){			//Add
					int nextIndex = findMissingNode(), coordX = int(mouseX - basePos.x), coordY = int(mouseY - basePos.y);
					if(mouseX>=basePos.x && mouseX<=basePos.x + baseW && mouseY>=basePos.y + baseH/7 && mouseY<=basePos.y + baseH){
						nodes.add(new NodeLectie(new PVector(coordX, coordY), color(0, 215, 32), baseW/20, baseW/20, 0.2, nextIndex, color(0, 243, 36)));
						graf.add(new IntList());	//somewhat inefficient
					}
				}
				/*else if(mouseButton==RIGHT){	//Connect	-> more in mouseDrag()

				}*/
				break;
			}
			case 2:{
				break;
			}
			case 3:{		//Reset		-> new init of graf
				graf = new ArrayList<IntList>();
				graf.add(new IntList());
				nodes = new ArrayList<NodeLectie>();
				edges = new ArrayList<EdgeLectie>();

				break;
			}
			case 5: {
				if(mouseButton==LEFT){	//Remove
					for(int j=edges.size()-1;j>=0;j--){				//edge deletion
						EdgeLectie edge = edges.get(j);
						if(edge.isOnLine(edge.sPoint.basePos, edge.fPoint.basePos, new PVector(mouseX, mouseY))){
							removeFromGraf(nodes.get(edge.sIndex).index + 1, nodes.get(edge.fIndex).index + 1);
							removeFromGraf(nodes.get(edge.fIndex).index + 1, nodes.get(edge.sIndex).index + 1);
							edges.remove(j);
						}
					}
				}
				break;
			}
			case 6: {
				if(mouseButton==LEFT){	//Remove
					for (int i=0;i<nodes.size();i++){
						NodeLectie node = nodes.get(i);
						if(node.isHovered(mouseX, mouseY)){
							int tmpIndex = node.index + 1;
							node.active = false;
							graf.get(tmpIndex).clear();

							for(int j=edges.size()-1;j>=0;j--){	
								EdgeLectie edge = edges.get(j);
								int index = edge.oneEnd(i);
								if(index!=-1){
									NodeLectie vec = nodes.get(index);
									IntList lst = graf.get(vec.index + 1);

									for(int k=lst.size()-1;k>=0;k--){
										int tmpInf = lst.get(k);

										if(tmpInf == tmpIndex){
											lst.remove(k);
											break;
										}
									}
									edges.remove(j);
								}
							}
							break;
						}
					}
					break;
				}
			}
		}
	}

	void mouseDrag(){
		if(indexBtn==4){		//Connect
			if(mouseButton==LEFT) for(int i=0;i<nodes.size();i++){			//=> working
				NodeLectie node = nodes.get(i);
				if(node.active && node.isHovered(mouseX, mouseY)){
					if(nodePrime==-1){
						nodePrime = i;
						break;
					}
					else if(nodeNeighbor==-1 && i!=nodePrime){		//Different ends
						nodeNeighbor = i;
						joinNodes(nodePrime, nodeNeighbor);
						break;
					} 
				}
			}
		}
		if(indexBtn==2){		//Move
			if(mouseButton==LEFT) for(NodeLectie node : nodes){
				if(node.active && node.isHovered(mouseX, mouseY) && (!nodeOnPossesion || node.index == nodeOnPossesionIndex)){
					int coordX = int(mouseX - basePos.x), coordY = int(mouseY - basePos.y);
					PVector coords = new PVector(coordX, coordY);
					nodeOnPossesion = true;
					nodeOnPossesionIndex = node.index;

					if(mouseX>=basePos.x && mouseX<=basePos.x + baseW && mouseY>=basePos.y + baseH/7 && mouseY<=basePos.y + baseH){
						node.basePos = coords;
						node.seekPosition(coords);
						break;
					}
				}
			}
		}
	}

	void mouseRelease(){
		nodeOnPossesion = false;
		nodePrime = nodeNeighbor = -1;
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
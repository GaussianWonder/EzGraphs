class MuchiiGR{
	IntList st, dr;

	MuchiiGR(){
		st = new IntList();
		dr = new IntList();
	}

	void add(int s, int d){
		st.append(s);
		dr.append(d);
	}

	boolean exists(int s, int d){
		for(int i=0;i<st.size();++i)
			if( (st.get(i)==s && dr.get(i)==d) || (st.get(i)==d && dr.get(i)==s) )
				return true;
		return false;
	}

	void display(){
		for(int i=0;i<st.size();++i){
			int n = st.get(i);
			int v = dr.get(i);

			Node nod = nodes.get(n);
			Node vec = nodes.get(v);

			strokeWeight(6);
			stroke(255, 82, 44);

			line(nod.basePos.x, nod.basePos.y, vec.basePos.x, vec.basePos.y);
		}
	}

}
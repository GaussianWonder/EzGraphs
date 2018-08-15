class TextBoxTeo extends Obj{
	PVector addPos;
	String data = "";
	boolean focus = false;
	float leading, txtSz, descent, ascent, initW, initH, baseAngle = 10, seekAngle = 50;
	int endlines = 0, lineIndex = 0, index;
	color normal, hover, active;

	TextBoxTeo(PVector pos, color c, float w, float h, float anim, color hov, color act, float lead, float sz, int i){
		super(pos, c, w, h, anim);
		normal = c;
		hover = hov;
		active = act;

		leading = lead;
		txtSz = sz;
		textSize(txtSz);
		textLeading(leading);
		descent = textDescent() * 0.8;
		ascent = textAscent() * 0.8;

		initW = w;
		initH = h;

		index = i;

		addPos = new PVector(0, 0);
	}

	void display(){
		noStroke();
		fill(baseCol);
		rect(addPos.x + basePos.x, addPos.y + basePos.y, baseW, baseH, baseAngle);

		fill(42);
		//textAlign(LEFT);
		textSize(txtSz);
		textLeading(leading);
		text(data, addPos.x + basePos.x, addPos.y + basePos.y, baseW, baseH);

		stroke(42);
		strokeWeight(1);
		if(frameCount % 60 < 30 && focus){
			PVector pos = calcLinePos(lineIndex);
			line(addPos.x + basePos.x + pos.x, addPos.y + basePos.y + pos.y + descent + ascent, addPos.x + basePos.x + pos.x, addPos.y + basePos.y + pos.y);
		}
	}

	void update(){
		animate();
		textSize(txtSz);
		baseAngle = lerp(baseAngle, seekAngle, animSpd);
		if(keyPressed){
			float localW = textWidth(data) + 2 * txtSz;
			float localH = descent + (txtSz + (txtSz - leading)) * (endlines + 1.5);

			if(initW < localW) seekWidth(localW);
			if(initH < localH) seekHeight(descent + (txtSz + (txtSz - leading)) * (endlines + 1.5));
		}

		if(focus){
			seekAngle = 0;
			seekColor(active);
		}
		else if(isHovered(mouseX, mouseY)) seekColor(hover);
		else {
			seekAngle = 50;
			seekColor(normal);
		}

		if(lineIndex>data.length())lineIndex = data.length();
		else if(lineIndex<0)lineIndex = 0;
	}

	boolean isHovered(float x, float y){
		return(x>=addPos.x + basePos.x && x<=addPos.x + basePos.x + baseW && y>=addPos.y + basePos.y && y<=addPos.y + basePos.y + baseH);
	}

	PVector calcLinePos(int lineIndex){
		if(data.equals(""))return(new PVector(0, 0));
		int endlns = 0, endlnIndex = -1;
		String txtSample = "";

		for(int i=0;i<data.length();i++){
			if(i<lineIndex){
				txtSample += data.charAt(i) + "";
				if(data.charAt(i) == '\n'){
					endlns++;
					endlnIndex = i;
					txtSample = "";
				}
			}
		}

		return new PVector(textWidth(txtSample), descent + (txtSz + (txtSz - leading)) * endlns);
	}

	void keyIsPressed(){
		if(key == CODED){	//Special keys
			if(keyCode == ALT) return;

			switch (keyCode) {
				case DOWN:{
					do{
						lineIndex++;
					}while (lineIndex < data.length() && data.charAt(lineIndex)!='\n');
					lineIndex++;
					if(lineIndex>data.length())
						lineIndex = data.length();
					break;
				}
				case UP:{
					lineIndex-=2;
					if(lineIndex < 0){
						lineIndex = 0;
						break;
					}

					do{
						lineIndex--;
					}while (lineIndex > 0 && data.charAt(lineIndex)!='\n');
					lineIndex++;

					if(lineIndex < 0) lineIndex = 0;
					else if(lineIndex == 1)lineIndex = 0;

					break;
				}
				case LEFT:{
					lineIndex--;
					if(lineIndex<0)
						lineIndex=0;
					break;
				}
				case RIGHT:{
					lineIndex++;
					if(lineIndex>data.length())
						lineIndex = data.length();
					break;
				}
			}
		} else switch (key) {
			case ESC:{
				int i;
				break;
			}
			case BACKSPACE:{
				delRightAt(lineIndex - 1);
				lineIndex--;
				break;
			}
			case DELETE:{
				delLeftAt(lineIndex - 1);
				break;
			}
			case TAB:{
				if(textWidth(data + "     " + "") > seekW)
						return;
				data += "     ";
				lineIndex += 5;
				break;
			}
			case ENTER:{
				data += '\n' + "";
				endlines++;
				lineIndex++;
				break;
			}
			case RETURN:{
				data += '\n' + "";
				endlines++;
				break;
			}
			default:{
				if( int(key) == 22 ){			//paste from clipboard CTRL + V
					Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
 					Transferable contents = clipboard.getContents(null);
 					DataFlavor flavor = DataFlavor.stringFlavor;
 					Object contentData = null;

					if (contents != null && contents.isDataFlavorSupported(flavor)){
						try{
							contentData = contents.getTransferData(flavor);
						}
						catch (UnsupportedFlavorException exu){		//Completely Optional -> no freeze to death tho
							println("Unsupported flavor: " + exu);
						}
						catch (java.io.IOException exi){
							println("Unavailable data: " + exi);
						}
					}

					data = (String) contentData;

					endlines = 0;
					for(int i=0; i<data.length();i++)
						if(data.charAt(i)=='\n')
							endlines++;
					break;
				}
				else if(int(key) == 3){		//copy to clipboard CTRL + C
					Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
					StringSelection selection = new StringSelection(data);
					clipboard.setContents(selection, selection);
					break;
				}
				else if( (key>='a' && key<='z') || (key>='A' && key<='Z') || (key>='0' && key<='9') || 1==1){
					if(textWidth(data + key + "") > seekW)
						return;
					insertAt(lineIndex);
					lineIndex++;
				}
				break;
			}
		}
	}

	void insertAt(int index){
		if(data.equals("") || index == data.length()){
			data += key + "";
			return;
		}

		String newData = "";
		for(int i=0;i<data.length();i++){
			if(i==index) newData += key;
			newData += data.charAt(i);
		}
		data = newData;
	}

	void delRightAt(int index){
		String newData = "";
		for(int i=0;i<data.length();i++){
			if(i==index && data.charAt(i)=='\n')
				endlines--;
			if(i!=index)
				newData += data.charAt(i);
		}
		data = newData;
	}

	void delLeftAt(int index){
		String newData = "";
		for(int i=0;i<data.length();i++){
			if(i==index + 1 && data.charAt(i)=='\n')
				endlines--;
			if(i!=index + 1)
				newData += data.charAt(i);
		}
		data = newData;
	}
}

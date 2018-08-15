void mousePressed(){
	currForm.mouseEvents();
	/*
	if(tst.isHovered(mouseX, mouseY))
		tst.focus = true;
	else tst.focus = false;

	if(tstBtn.isHovered(mouseX, mouseY)){
		if(tstBtn.toggle==true)
			tstBtn.toggle = false;
		else tstBtn.toggle = true;
	}
	*/
}

void mouseReleased(){
	if(currForm.currIndex == 2 && currForm.forms.get(1).grafLectie!=null)
		currForm.forms.get(1).grafLectie.mouseRelease();
}

void mouseDragged(){
	if(currForm.currIndex == 2 && currForm.forms.get(1).grafLectie!=null)
		currForm.forms.get(1).grafLectie.mouseDrag();
}
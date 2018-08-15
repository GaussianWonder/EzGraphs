void initialize_TestView() {
	R_TestView=width/20;

	questionActive_TestView=0;
	nQuestions_TestView=0;

	nQuestionsMax_TestView=10;

	start_TestView=new buton_TestView(width/2-R_TestView*2,height/2-R_TestView/2,R_TestView*4,R_TestView,"Incepe testul");

	add_test_TestView("testData");
	add_question_TestView("Submit","","","",0);
}
void dbConnect(){
  db = new MySQL(thisPapplet, "localhost", "ezgraphs", "root", "");    //localhost
  if(db.connect())error = false;
  else{
      error = true;
      ERRtime = millis();
  }
}

String crypt(String pass){
	String hash = BCrypt.hashpw(pass, BCrypt.gensalt(saltCrypt));

	if (BCrypt.checkpw(pass, hash)) return hash;
	else return "{ERR}";
}

boolean checkCrypted(String pass, String hash){
	return BCrypt.checkpw(pass, hash);
}
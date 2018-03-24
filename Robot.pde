void cmd(String cmd) {
  queue.add(cmd);
}

void update() {
  if (port==null) return;

  while (port.available() > 0) {
    char c = port.readChar();
    print(c);
    ready = (c=='>');
  }

  if (ready) nextInQueue();
}

void nextInQueue() {
  if (!ready) return;
  if (queue.size()<=0) { 
    return;
  }
  ready = false;
  if (port!=null) port.write(queue.get(0) + "\r");
  else println("SIM: " + queue.get(0)); 
  queue.remove(0);
}
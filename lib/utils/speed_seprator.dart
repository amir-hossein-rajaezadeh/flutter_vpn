String vpnSpeed(String speed) {
  speed = speed.split("/")[0];
  print("ddfddf $speed");
  speed = speed.replaceAll('B', '');
  speed = speed.replaceAll('K', '');
  speed = speed.replaceAll('M', '');
  return speed;
}

String vpnType(String speed) {
  speed = speed.substring(speed.indexOf(".") + 3);
  return speed;
}

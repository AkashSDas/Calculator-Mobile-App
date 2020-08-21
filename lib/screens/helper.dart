String getOperationSign(String operation) {
  if (operation == 'add') {
    return '+';
  } else if (operation == 'subtract') {
    return '-';
  } else if (operation == 'multiply') {
    return '*';
  } else if (operation == 'divide') {
    return '/';
  }
  return '';
}

String getOperationDisplaySign(String operation) {
  if (operation == 'add') {
    return '+';
  } else if (operation == 'subtract') {
    return '-';
  } else if (operation == 'multiply') {
    return '\u{00D7}';
  } else if (operation == 'divide') {
    return '\u{00F7}';
  }
  return '';
}

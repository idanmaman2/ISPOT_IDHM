
  class FileStackOverFlow implements Exception {
  
    ValueException([String message = 'Invalid value']) {
    }
  
    @override
    String toString() {
      return "there is not an empty file to save the song , try recreating the stack";
    }
  }
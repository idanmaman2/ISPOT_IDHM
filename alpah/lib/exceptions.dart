
  class FileStackOverFlow implements Exception {
  
    @override
    String toString() {
      return "there is not an empty file to save the song , try recreating the stack";
    }
  }

  class   StackSizeTooSmall implements Exception {
  
  
    @override
    String toString() {
      return "the stack size is negative is zero - please change it to be positive";
    }
  }
    class   ThereIsntFile implements Exception {
  
  
    @override
    String toString() {
      return "thre osnt file with that name";
    }
  }